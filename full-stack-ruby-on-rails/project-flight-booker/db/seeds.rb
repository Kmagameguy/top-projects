# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

AIRPORT_CODES = %w[
  ATL
  DFW
  DEN
  ORD
  LAX
  CLT
  MCO
  LAS
  PHX
  MIA
  SEA
  IAH
  JFK
  EWR
  FLL
  MSP
  SFO
  DTW
  BOS
  SLC
  PHL
  BWI
  TPA
  SAN
  LGA
  MDW
  BNA
  IAD
  DCA
  AUS
].freeze

Airport.destroy_all
Flight.destroy_all
Airport.create!(AIRPORT_CODES.map { |code| { code: } })

puts "Created #{Airport.count} airports."

(AIRPORT_CODES.count - 1).times do |i|
  Flight.create!(departure_airport_id: AIRPORT_CODES.first, arrival_airport_id: AIRPORT_CODES[i + 1])
end

puts "Created #{Flight.count} flights."
