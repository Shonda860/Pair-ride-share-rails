class AddTripIdToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_reference :drivers, :trip, index: true
  end
end
