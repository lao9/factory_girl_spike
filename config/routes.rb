Rails.application.routes.draw do

  resources :items, only: [:index]
  # resources :categories, only: [:show]

  resources :carts, only: [:index, :create]










  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
