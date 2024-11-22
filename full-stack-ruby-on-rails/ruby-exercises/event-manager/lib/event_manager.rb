# frozen_string_literal: true

require 'csv'
puts 'Event Manager Initialized!'

filename = 'event_attendees.csv'
contents = CSV.open(
  filename,
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  puts name
end
