Rails.application.routes.draw do

  root "application#welcome"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :destinations do
    resources :ratings
  end

  post "/users/:id", to: "relationships#create", as: "new_relationship"
  delete "/users/:id", to: "relationships#destroy", as: "destroy_relationship"
  resources :relationships, only: [:index]

  get "/trips/:id/new_destinations", to: "trips#new_destinations", as: "new_destinations"
  patch "/trips/:id/create_destinations", to: "trips#create_destinations", as: "create_destinations"
  resources :trips do
    resources :reviews
  end
  resources :users, only: [:show, :new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
