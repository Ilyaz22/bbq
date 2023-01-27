Rails.application.routes.draw do
  devise_for :users

  root to: "events#index"

  resources :comments
  resources :users, only: [:show, :edit, :update]

  resources :events do
    resources :comments, only: [:create, :destroy]
  end
end
