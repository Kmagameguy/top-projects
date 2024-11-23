class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports, id: false do |t|
      t.string :code, null: false, primary_key: true

      t.timestamps
    end
  end
end
