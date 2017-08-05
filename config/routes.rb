Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  devise_for :users, path: 'api/v1/', controllers: { sessions: 'sessions', registrations: 'registrations' }

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
          put :mark_correct
        end
      end
      resources :replies
      resources :categories
      resources :tags do
        collection do
          put :autocomplete
        end
      end
      resources :users, only: %i(index show update) do
        collection do
          put :autocomplete
          get :me
          get :exists
        end
      end
      resources :reports, only: [:index] do
        collection do
          put :volume_trends
          put :sentiment_trends
        end
      end
      resources :tag_filters
      resources :notifications, only: [:index, :update]
      resources :settings, only: %i(update show index)
    end
  end
end
