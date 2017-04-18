Rails.application.routes.draw do
  root to: 'items#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'
  # Then my current page should be "/dashboard"
  resources :users, only: [:new, :create]

  get '/dashboard', to: 'users#show', as: 'user'


  resources :items, only: [:index, :show]

  put '/cart/remove', :to => 'carts#remove'

  resource :cart, only: [:show, :create, :update]

  resources :orders, only: [:create, :index, :show, :update]

  namespace :admin do
    get '/dashboard', to: "users#admin_dash"
    resources :users, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :edit]
  end

  match '/send_report', via: :post, to: "admin/users#sales_report"

























  #STAY DOWN
  get "/:category_name", to: "categories#show"
end
