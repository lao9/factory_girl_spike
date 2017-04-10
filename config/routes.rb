Rails.application.routes.draw do

  resources :items, only: [:index]
  # resources :categories, only: [:show]
  get "/:category_name", to: "categories#show"
end
