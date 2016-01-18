Rails.application.routes.draw do
  root to: "storms#index"
  resources :storms, only: [:index, :show]
  resources :drafts, only: [:new]
  resources :storm_checks, only: [:create]
end
