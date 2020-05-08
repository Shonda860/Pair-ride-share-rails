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
end
