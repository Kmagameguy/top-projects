# frozen_string_literal: true

require 'csv'

def clean_zipcode(zipcode)
  # Ensure all zipcodes a strings,
  # Then prefix them with zeroes until their length is 5
  # Otherwise if the length is more than 5, return the first 5 digits only
  # This handles nils because nil.to_s = ''
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'Event Manager Initialized!'

filename = 'event_attendees.csv'
contents = CSV.open(
  filename,
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end
