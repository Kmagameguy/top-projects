class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports, id: false do |t|
      t.string :code

      t.timestamps
    end
  end
end
