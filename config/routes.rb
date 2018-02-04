Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create]
      namespace :users do
        post :authenticate
      end
    end
  end
end
