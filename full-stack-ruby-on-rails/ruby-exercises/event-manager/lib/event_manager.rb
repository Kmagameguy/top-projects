# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

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

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials

    legislator_names = legislators.map(&:name)

    legislators_string = legislator_names.join(', ')
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

  puts "#{name} #{zipcode} #{legislators_string}"
end
