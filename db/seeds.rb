# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? && User.count == 0
  User.create(
    name: 'Aldi Zainafif',
    email: 'aldi@zain.afif',
    phone_number: '081234567890',
    address: 'Pesona Bali Ciwaruga',
    password: 'aldi00',
    email_verified: true
  )
end

# User.create(
#   name: 'Retno Dewi Hartianti',
#   email: 'r.hartianti@gmail.com',
#   phone_number: '085722648575',
#   address: 'Pesona Bali Ciwaruga Juga',
#   password: 'retno',
#   email_verified: true
# )