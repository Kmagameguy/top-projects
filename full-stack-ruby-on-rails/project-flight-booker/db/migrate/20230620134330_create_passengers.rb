class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :email
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
