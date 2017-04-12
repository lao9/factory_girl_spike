Rails.application.routes.draw do
  root to: 'items#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  # Then my current page should be "/dashboard"
  resources :users, only: [:new, :create]

  get '/dashboard', to: 'users#show', as: 'user'

  # delete '/logout', to: 'sessions#destroy'

  resources :items, only: [:index, :show]

  put '/cart/remove', :to => 'carts#remove'

  resource :cart, only: [:show, :create, :update]

  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
