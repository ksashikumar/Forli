Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: '/api/v1/auth'

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
            put :hit
            put :upvote
            put :downvote
            put :view
          end
        end
        member do
          put :hit
          put :upvote
          put :downvote
          put :view
        end
      end
      resources :categories
      resources :tags
      resources :users

      resources :settings, only: [:update, :show, :index]
    end
  end
end
