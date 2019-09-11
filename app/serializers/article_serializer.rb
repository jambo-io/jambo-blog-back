class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :article, :wall_url

  def id
    object.id
  end
  def test
    1
  end
  def wall_url
    if object.wall.present?
      Rails.application.routes.url_helpers.rails_blob_path(object.wall, only_path: true)
    end
  end


end
