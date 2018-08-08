Rails.application.routes.draw do
  root 'weclome#index'

  resources :users
  resources :sessions

  delete '/logout' => 'sessions#destroy', as: :logout
end
