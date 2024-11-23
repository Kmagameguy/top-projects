class CreateKittens < ActiveRecord::Migration[7.0]
  def change
    create_table :kittens do |t|
      t.string :name, null: false
      t.integer :age, null: false
      t.integer :cuteness, null: false
      t.integer :softness, null: false

      t.timestamps
    end
  end
end
