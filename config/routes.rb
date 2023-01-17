Rails.application.routes.draw do
  root to: "events#index"

  resources :users, only: [:show, :edit, :update]
  resources :events
end
