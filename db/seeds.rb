# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create! name: "admin"

(0..5).each do |i|
  User.create!( name:  "Member#{i+1}",
    email: "member#{i+1}@gmail.com",
    password: "123456789",
    password_confirmation: "123456789",
    role_id: 1
  )
end
