Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:index]
  # resources :categories, only: [:show]

  resources :carts, only: [:index, :create]










  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
