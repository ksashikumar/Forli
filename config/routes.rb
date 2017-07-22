Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'
  mount ActionCable.server => '/cable'

  scope '/api' do
    scope '/v1' do
      resources :discussions do
        resources :comments do
          member do
            get :children
          end
        end
        resources :posts do
          resources :comments do
            member do
              get :children
            end
          end
          member do
            put :upvote
            put :downvote
            put :view
          end
        end
        member do
          put :upvote
          put :downvote
          put :view
          post :similar, to: 'search#similar_discussions'
        end
        collection do
          post :suggest, to: 'search#suggested_discussions'
          post :search, to: 'search#results'
        end
      end
      resources :categories
      resources :tags
      resources :users

      resources :settings, only: [:update, :show, :index]
    end
  end
end
