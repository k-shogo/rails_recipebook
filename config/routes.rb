Rails.application.routes.draw do
  resources :comments

  devise_for :users

  resources :events, shallow: true do
    resources :presentations do
      resources :documents
    end
  end

  resources :categories

  resources :places

  root to: 'events#index'

end
