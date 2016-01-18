Rails.application.routes.draw do
  resources :drafts, only: [:index]
end
