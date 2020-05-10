class RemovedTripsIdFromTrips < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :trip_id
  end
end
