class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.Integer :id
      t.String :name
      t.String :phone_num

      t.timestamps
    end
  end
end
