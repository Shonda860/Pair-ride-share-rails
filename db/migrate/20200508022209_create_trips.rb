class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.Integer :id
      t.Integer :driver_id
      t.Integer :passenger_id
      t.String :date
      t.Integer :rating
      t.Integer :cost

      t.timestamps
    end
  end
end
