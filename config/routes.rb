Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'

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
