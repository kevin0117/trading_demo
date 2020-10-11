Rails.application.routes.draw do
  # Users
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]

  # Sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root "bootstrap#index"
end
