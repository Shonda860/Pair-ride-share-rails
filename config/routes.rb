Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/trips", to: "trips#index", as: :trips # all trips
  post "/trips", to: "trips#create"
  get "/trips/new", to: "trips#new", as: :new_trip
  get "/trips/:id", to: "trips#show", as: :trip
  patch "/trips/:id", to: "trips#update"
  put "/trips/:id", to: "trips#update"
  delete "/trips/:id", to: "trips#destroy"
  get "/trips/:id/edit", to: "trips#edit", as: :edit_trip

  get "/drivers", to: "drivers#index", as: :drivers # all drivers
  post "/drivers", to: "drivers#create"
  get "/drivers/new", to: "drivers#new", as: :new_driver
  get "/drivers/:id", to: "drivers#show", as: :driver
  patch "/drivers/:id", to: "drivers#update"
  put "/drivers/:id", to: "drivers#update"
  delete "/drivers/:id", to: "drivers#destroy"
  get "/drivers/:id/edit", to: "drivers#edit", as: :edit_driver

  get "/passengers", to: "passengers#index", as: :passengers # all passengers
  post "/passengers", to: "passengers#create"
  get "/passengers/new", to: "passengers#new", as: :new_passenger
  get "/passengers/:id", to: "passengers#show", as: :passenger
  patch "/passengers/:id", to: "passengers#update" 
  put "/passengers/:id", to: "passengers#update" 
  delete "/passengers/:id", to: "passengers#destroy"
  get "/passengers/:id/edit", to: "passengers#edit", as: :edit_passenger
end
