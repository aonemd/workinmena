Rails.application.routes.draw do
  root to: 'api/v1/companies#index'

  namespace :api, default: { format: :json } do
    namespace :v1 do
      resources :companies, only: [:index, :show, :create] do
        resources :stacks, only: [:create] do
          member do
            put :endorse
          end
        end
      end

      namespace :companies do
        resources :submissions, only: [:create]
        resource :analyzer, controller: :analyzer, only: [:create]
      end

      resources :tools, only: [:index]
    end
  end
end
