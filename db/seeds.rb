# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

last_light = Hospital.create!(name:'Last Light of Baleros')
shh = Hospital.create!(name:'Sacred Heart Hospital')

geneva = last_light.doctors.create!(name: 'Dr. Geneva', specialty: 'Trauma', university: 'Some School State')
house = last_light.doctors.create!(name: 'House MD', specialty: 'Who knows', university: 'Some Other State')
braff = shh.doctors.create!(name: 'Snack Braff', specialty: 'Wrestling', university: 'WV School of Medical Dance')

geneva.patients.create!(name: 'Ken', age: 22)
geneva.patients.create!(name: 'Jordie', age: 22)
house.patients.create!(name: 'Neil', age: 75)
braff.patients.create!(name: 'Mary', age: 47)
