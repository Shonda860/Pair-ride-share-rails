Rails.application.routes.draw do
  # get 'homepages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homepages#index"

  resources :drivers
  resources :passengers
  resources :trips, except: [:index, :new, :create]

  post "/trips/:passenger_id ", to: "trips#passenger_trip", as: "passenger_trip"
  patch "/trips/:id/mark_complete", to: "trips#mark_complete", as: "mark_complete"
end
