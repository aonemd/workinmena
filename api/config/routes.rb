Rails.application.routes.draw do
  root to: 'api/v1/companies#index'

  namespace :api, default: { format: :json } do
    namespace :v1 do
      resources :companies, only: [:index, :show, :create]

      namespace :companies do
        resources :submissions, only: [:create]
      end

      resources :tools, only: [:index]
    end
  end
end
