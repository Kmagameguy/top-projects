# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  # Ensure all zipcodes a strings,
  # Then prefix them with zeroes until their length is 5
  # Otherwise if the length is more than 5, return the first 5 digits only
  # This handles nils because nil.to_s = ''
  zipcode.to_s.rjust(5, '0')[0..4]
end

def remove_country_code?(phone_number)
  phone_number.length == 11 && phone_number[0] == 1
end

def clean_phone_number(phone_number)
  phone_number = phone_number.to_s.delete('^0-9').chars
  phone_number = phone_number.drop(1) if remove_country_code?(phone_number)
  if phone_number.size != 10
    '000-000-0000'
  else
    phone_number = phone_number.join('')
    "#{phone_number[0..2]}-#{phone_number[3..5]}-#{phone_number[6..9]}"
  end
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'Event Manager Initialized!'

filename = 'event_attendees.csv'

contents = CSV.open(
  filename,
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end
