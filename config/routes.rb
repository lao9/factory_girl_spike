Rails.application.routes.draw do
  root to: 'items#index'
  # And I should be on the "/login" page
  # Then my current page should be "/dashboard"

  resources :items, only: [:index, :show]

  put '/cart/remove', :to => 'carts#remove'

  resource :cart, only: [:show, :create, :update]

  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
