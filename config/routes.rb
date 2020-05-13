Rails.application.routes.draw do
  # get 'homepages/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "homepages#index"

  resources :drivers
  resources :passengers
  resources :trips, except: [:index, :new, :create]

  post "/trips/:passenger_id ", to: "trips#passenger_trip", as: "passenger_trip"
  patch "/trips/:id/mark_complete", to: "trips#mark_complete", as: "complete"
end

# TO DO:
# refactor routes using resources
# remove all routes except custom routes
# something like this:
# resources :passengers
# resources :drivers
# resources :trips

# TO DO:
# create a root_path
# root to: "something#index"

# get "/trips", to: "trips#index", as: :trips # all trips #EXCLUDES
# get "/trips/new", to: "trips#new", as: :new_trip
# post "/trips", to: "trips#create"

# get "/trips/:id", to: "trips#show", as: :trip
# get "/trips/:id/edit", to: "trips#edit", as: :edit_trip
# patch "/trips/:id", to: "trips#update"
# put "/trips/:id", to: "trips#update"
# delete "/trips/:id", to: "trips#destroy"

# get "/drivers", to: "drivers#index", as: :drivers # all drivers
# get "/drivers/new", to: "drivers#new", as: :new_driver
# post "/drivers", to: "drivers#create"

# get "/drivers/:id", to: "drivers#show", as: :driver
# get "/drivers/:id/edit", to: "drivers#edit", as: :edit_driver
# delete "/drivers/:id", to: "drivers#destroy"
# patch "/drivers/:id", to: "drivers#update"

# get "/passengers", to: "passengers#index", as: :passengers # all passengers
# post "/passengers", to: "passengers#create"
# get "/passengers/new", to: "passengers#new", as: :new_passenger
# get "/passengers/:id", to: "passengers#show", as: :passenger
# patch "/passengers/:id", to: "passengers#update"
# put "/passengers/:id", to: "passengers#update", as: :update_passenger
# delete "/passengers/:id", to: "passengers#destroy", as: :delete_passenger
# get "/passengers/:id/edit", to: "passengers#edit", as: :edit_passenger
# patch "/passengers/:id", to: "passengers#update"
# end

# This comment is for testing purposes only
