class RemovePassengerIdId < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :passenger_id_id
  end
end
