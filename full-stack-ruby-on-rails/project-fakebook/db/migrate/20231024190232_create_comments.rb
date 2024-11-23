class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :commentable_id
      t.text :commentable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
