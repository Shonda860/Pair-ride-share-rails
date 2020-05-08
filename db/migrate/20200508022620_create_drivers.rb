class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.Integer :id
      t.String :name
      t.String :vin
      t.Boolean :available

      t.timestamps
    end
  end
end
