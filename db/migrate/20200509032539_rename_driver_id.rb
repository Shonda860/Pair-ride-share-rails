class RenameDriverId < ActiveRecord::Migration[6.0]
  def change
    rename_column :trips, :driver_id, :driver
  end
end
