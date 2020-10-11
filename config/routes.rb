Rails.application.routes.draw do
  # Users
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]

  # Sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Commodities
  resources :commodities, except: [:show] do
    member do
      post 'deal', to: 'commodities#deal'
    end
  end

  # Sidekiq
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  root "bootstrap#index"
end
