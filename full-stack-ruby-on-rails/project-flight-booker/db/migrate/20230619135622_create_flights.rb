class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.string :departure_airport_id, null: false
      t.string :arrival_airport_id, null: false

      t.timestamps
    end
  end
end
