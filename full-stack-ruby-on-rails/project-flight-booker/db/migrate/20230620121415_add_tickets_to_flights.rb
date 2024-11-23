class AddTicketsToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :num_tickets, :integer, null: false, default: 1
  end
end
