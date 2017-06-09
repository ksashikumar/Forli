Rails.application.routes.draw do

  api_routes = proc do
    resources :discussions do
      resources :posts
    end
    resources :comments
    resources :categories
    resources :tags
  end

  scope '/api', defaults: { version: 'v1', format: 'json' }, constraints: { format: /(json|$^)/ } do
    scope '/v1', &api_routes
  end
end
