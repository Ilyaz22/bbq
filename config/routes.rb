Rails.application.routes.draw do
  resources :photos
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}

  root to: "events#index"

  resources :subscriptions

  resources :events do
    resources :comments, only: [:create, :destroy]
    resources :subscriptions, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
end
