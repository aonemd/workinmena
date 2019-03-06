Rails.application.routes.draw do
  root to: 'api/v1/companies#index'

  namespace :api, default: { format: :json } do
    namespace :v1 do
      resources :companies, only: [:index, :create]
    end
  end
end
