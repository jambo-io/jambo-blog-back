class Article < ApplicationRecord
    has_one_attached :wall

    include ActionView::Helpers::DateHelper

    def wall_url
        if self.wall.present?
          Rails.application.routes.url_helpers.rails_blob_path(self.wall, only_path: true)
        end
    end

    def wall_thumb_url
        if self.wall.present?
          require "mini_magick"
          Rails.application.routes.url_helpers.rails_representation_url(self.wall.variant(resize: "300x300").processed, only_path: true)
        end
    end

    def created_time_ago

        time_ago_in_words(self.created_at) unless self.created_at.blank?
    end

end
