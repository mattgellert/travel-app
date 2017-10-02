Rails.application.routes.draw do
  resources :trip_locations
  resources :locations
  resources :destinations
  resources :ratings
  resources :relationships
  resources :trip_destinations
  resources :reviews
  resources :trips
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
