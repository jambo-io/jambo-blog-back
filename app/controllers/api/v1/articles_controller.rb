
class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  include Rails.application.routes.url_helpers
  # GET /articles
  def index

    current_page = params[:current_page].to_i
    limit = params[:limit].to_i
    offset = current_page * limit ||=0
    has_more = true

    total_articles = Article.count
    if (total_articles % limit == 0 )
      total_pages = (total_articles / limit).to_i - 1
    else 
      total_pages = (total_articles / limit).to_i
    end

    if current_page > total_pages 
      render json: {
        status: 404,
        message: "No more data"
      }
      return nil
    end
    
    if (current_page == 1)
      has_more = false
    end
    
    @articles = Article.all.offset(offset).limit(limit)
    
    articles_array = []
    @articles.each do |article|
        thumb_url = nil
        if article.wall.present?
          thumb_url = article.wall_thumb_url
        end
        article_json = {
          id: article.id,
          title: article.title,
          article: article.article,
          wall_thumb_url: thumb_url,
          created_at: article.created_time_ago
        }
        articles_array.unshift(article_json)
    end

     render json: {
       current_page: current_page,
       total_pages: total_pages,
       total_articles: total_articles,
       limit: limit,
       has_more: has_more,
       articles: articles_array
     }
    
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    if @article.destroy
      render json: {
        status: 200,
        message: 'OK'
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title, :article, :wall)
    end
end
