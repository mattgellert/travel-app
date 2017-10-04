Rails.application.routes.draw do

  root "application#welcome"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/tripsearch", to: "trips#search", as: "trip_search"
  get "/destsearch", to: "destinations#search", as: "destination_search"
  resources :destinations do
    resources :ratings, only: [:new, :create, :show, :edit, :update]
  end

  post "/users/:id", to: "relationships#create", as: "new_relationship"
  delete "/users/:id", to: "relationships#destroy", as: "destroy_relationship"
  get "/users/:id/followers", to: "users#followers", as: "followers"
  get "/users/:id/followees", to: "users#followees", as: "followees"
  resources :relationships, only: [:index]

  get "/trips/:id/new_destinations", to: "trips#new_destinations", as: "new_destinations"
  patch "/trips/:id/create_destinations", to: "trips#create_destinations", as: "create_destinations"
  get "/trips/:id/edit_destinations", to: "trips#edit_destinations", as: "edit_destinations"
  patch "/trips/:id/update_destinations", to: "trips#update_destinations", as: "update_destinations"
  resources :trips do
    resources :reviews, only: [:new, :create, :show, :edit, :update]
  end
  resources :users, only: [:show, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
