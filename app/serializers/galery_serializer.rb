class GalerySerializer < ActiveModel::Serializer
  attributes :image

  def image
    if object.images.present?

      Rails.application.routes.url_helpers.rails_blob_path(object.images, only_path: true)
    end
  end
end
