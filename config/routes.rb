Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:index]

  # resources :carts, only: [:index]

  resource :cart, only: [:show, :create, :update]
  # custom /cart => cart#show


  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
