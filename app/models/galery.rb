class Galery < ApplicationRecord
    has_many_attached :images
    has_one_attached :upload
end