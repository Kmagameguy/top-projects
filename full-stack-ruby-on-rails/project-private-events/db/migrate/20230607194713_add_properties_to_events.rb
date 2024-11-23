class AddPropertiesToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :title, :string
    add_column :events, :description, :text
    add_column :events, :location, :string
  end
end
