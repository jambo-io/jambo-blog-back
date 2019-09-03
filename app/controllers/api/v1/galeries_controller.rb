class Api::V1::GaleriesController < ApplicationController
    def index
        puts "Parâmetros **"
        puts params
        render json: {
          "url": "https://example.com/images/foo.jpg"
        }
    end
    def ckeditor
        puts "params upload"
        galery = Galery.create(galery_params)
        puts galery.inspect
        if galery.present?
            path = Rails.application.routes.url_helpers.rails_blob_path(galery.upload, only_path: true)
            render json: {
                "uploaded": 1,
                "fileName": "foo.jpg",
                "url": "http://localhost:3000" + path
            }
        end
       
    end

    private
    def galery_params
        params.permit(:upload)
    end

end
