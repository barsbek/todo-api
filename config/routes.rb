Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :users do
        post :register
        post :authenticate
      end

      resources :lists
      resources :todos
    end
  end
end
