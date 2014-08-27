Rails.application.routes.draw do
  devise_for :users
  resources :documents

  resources :presentations

  resources :events

  resources :categories

  resources :places

  root to: 'events#index'

end
