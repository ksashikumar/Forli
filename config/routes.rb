Rails.application.routes.draw do

  scope '/api' do
    scope '/v1' do
      resources :discussions do
        resources :posts
      end
      resources :comments
      resources :categories
      resources :tags
    end
  end
end
