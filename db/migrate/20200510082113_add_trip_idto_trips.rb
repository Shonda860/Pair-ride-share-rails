class AddTripIdtoTrips < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :trip, index: true
  end
end
