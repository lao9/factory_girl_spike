Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:index]

  resources :carts, only: [:index, :create, :update]










  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
