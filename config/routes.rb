Rails.application.routes.draw do
  root to: "storms#index"
  resources :storms, only: [:index, :show, :destroy]
  resources :drafts, only: [:new]
  resources :storm_checks, only: [:create]
end
