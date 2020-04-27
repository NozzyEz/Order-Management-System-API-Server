# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.times do
    organization = Organization.new
    organization.name = "NozzyCore"
    organization.verification_code = "totally_legit"
end

1.times do
    user = User.new
    user.username = "Admin"
    user.first_name = "Mark"
    user.last_name = "Sahlgreen"
    user.email = "mark@nozzy.org"
    user.password = 'valid_password'
    user.password_confirmation = 'valid_password'
    user.role = "admin"
    user.save
    
end
