# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

User.create!(name: 'Roy Trenneman', email: 'roy.trenneman@reynholm.test', password: 'hunter2')
User.create!(name: 'Maurice Moss', email: 'maurice.moss@reynholm.test', password: '0118999881999197253')
User.create!(name: 'Jen Barber', email: 'jen.barber@reynholm.test', password: 'theshoes!!!')
User.create!(name: 'Douglas Reynholm', email: 'douglas@reynholm.test', password: 'elnumero1')
User.create!(name: 'Richmond Avenal', email: 'richmond@reynholm.test', password: 'goth2boss')

puts "Created #{User.count} users."
