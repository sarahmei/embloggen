Rails.application.routes.draw do
  resources :storms, only: [:index, :show]
  resources :drafts, only: [:new]
end
