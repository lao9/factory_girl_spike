Rails.application.routes.draw do

  resources :items, only: [:index, :show]

  resources :carts, only: [:index, :create]
  put '/carts/remove', :to => 'carts#remove'










  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
