Rails.application.routes.draw do
  root to: 'items#index'

  resources :items, only: [:index]

  resource :cart, only: [:show, :create, :update]

  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
