Rails.application.routes.draw do

  api_routes = proc do
    resources :questions do
    end
    resources :categories do
    end
    resources :tag do
    end
  end

  scope '/api', defaults: { version: 'v1', format: 'json' }, constraints: { format: /(json|$^)/ } do
    scope '/v1', &api_routes
  end
end
