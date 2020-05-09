Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: "drivers#index"

  get "/trips", to: "trips#index", as: :trips # all trips
  get "/trips/new", to: "trips#new", as: :new_trip
  post "/trips", to: "trips#create"

  get "/trips/:id", to: "trips#show", as: :trip
  get "/trips/:id/edit", to: "trips#edit", as: :edit_trip
  patch "/trips/:id", to: "trips#update"
  put "/trips/:id", to: "trips#update"
  delete "/trips/:id", to: "trips#destroy"

  get "/drivers", to: "drivers#index", as: :drivers # all drivers
  get "/drivers/new", to: "drivers#new", as: :new_driver

  post "/drivers", to: "drivers#create"

  get "/drivers/:id", to: "drivers#show", as: :driver
  get "/drivers/:id/edit", to: "drivers#edit", as: :edit_driver
  delete "/drivers/:id", to: "drivers#destroy"
  patch "/drivers/:id", to: "drivers#update"

  get "/passengers", to: "passengers#index", as: :passengers # all passengers
  get "/passengers/new", to: "passengers#new", as: :new_tpassenger
  post "/passengers", to: "passengers#create"

  get "/passengers/:id", to: "passengers#show", as: :passenger
  get "/passengers/:id/edit", to: "passengers#edit", as: :edit_passenger
  delete "/passengers/:id", to: "passengers#destroy"
  patch "/passengers/:id", to: "passengers#update"
end
