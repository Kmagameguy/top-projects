class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :email
      t.string :phone
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.date :birthday
      t.text :bio
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
