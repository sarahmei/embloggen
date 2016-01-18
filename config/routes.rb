Rails.application.routes.draw do
  resources :drafts, only: [:index, :show]
end
