Rails.application.routes.draw do
  # Users
  get 'sign_up', to: 'users#new'
  resources :users, except: [:new]

  root "bootstrap#index"
end
