class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :article, :wall

  def wall
    if object.wall.present?
    
      
      Rails.application.routes.url_helpers.rails_blob_path(object.wall, only_path: true)
    end
  end
end
