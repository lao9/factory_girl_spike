Rails.application.routes.draw do
  root to: 'items#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'
  # Then my current page should be "/dashboard"
  resources :users, only: [:new, :create]

  get '/dashboard', to: 'users#show', as: 'user'
  get '/shipping', to: 'users#edit', as: 'edit_user'
  patch '/shipping', to: 'users#update', as: 'update_user'
  get '/confirmation', to: 'carts#confirm', as: 'confirmation'

  resources :items, only: [:index, :show]

  put '/cart/remove', :to => 'carts#remove'

  resource :cart, only: [:show, :create, :update]

  resources :orders, only: [:create, :index, :show, :update]

  namespace :admin do
    get '/dashboard', to: "users#admin_dash"
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create]
  end


























  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
