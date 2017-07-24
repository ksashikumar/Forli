Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount_devise_token_auth_for 'User', at: '/api/v1/auths'
  mount ActionCable.server => '/cable'

  scope '/api' do
    scope '/v1' do
      resources :discussions do
        member do
          put :upvote
          put :downvote
          put :view
          put :similar, to: 'search#similar_discussions'
        end
        collection do
          put :suggest, to: 'search#suggested_discussions'
          put :search, to: 'search#results'
        end
      end
      resources :answers do
        member do
          put :upvote
          put :downvote
          put :view
        end
      end
      resources :replies
      resources :categories
      resources :tags do
        collection do
          put :autocomplete
        end
      end
      resources :users, only: %i[index show update] do
        collection do
          put :autocomplete
        end
      end
      resources :reports, only: [:index] do
        collection do
          put :volume_trends
          put :sentiment_trends
        end
      end

      resources :notifications, only: [:index, :update]
      resources :settings, only: %i[update show index]
      resources :bootstrap, controller: 'bootstrap', only: :index
    end
  end
end
