class ArticleSerializer < ActiveModel::Serializer
  self.representation_wrap = :data
  attribute :test
  attributes :id, :title, :article, :wall_url

  def test
    1
  end
  def wall_url
    if object.wall.present?
      Rails.application.routes.url_helpers.rails_blob_path(object.wall, only_path: true)
    end
  end


end
