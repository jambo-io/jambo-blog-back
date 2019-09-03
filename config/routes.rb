Rails.application.routes.draw do
    
    namespace :api do
        namespace :v1 do
          get 'ckeditor' => 'galeries#index'
          post 'ckeditor' => 'galeries#ckeditor'
          resources :articles
      end
    end
end

