Rails.application.routes.draw do
  resources :storms, only: [:index, :show]
end
