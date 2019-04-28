# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Reservation.destroy_all
City.destroy_all
User.destroy_all
Room.destroy_all
JoinTableMessageRecipient.destroy_all
PrivateMessage.destroy_all
puts "Previous records cleared."

10.times do
  City.create!(name: Faker::Address.city,
  zip_code: Faker::Address.zip_code)
end
puts "10 fake cities generated."

20.times do
  User.create!(city_id: City.all.sample.id,
  email: Faker::Internet.email,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  description: Faker::Lorem.sentence(rand(10..20)),
  phone_nb: Faker::Code.sin)
end
puts "20 fake users generated."

50.times do
  Room.create!(city_id: City.all.sample.id,
  admin_id: User.all.sample.id,
  nb_bed: rand(1..5),
  price_per_bed_pernight: rand(7.99...1000).round(2),
  has_wifi: Faker::Boolean.boolean(0.7),
  description: Faker::Lorem.sentence(rand(30..50)),
  welcome_message: Faker::Lorem.sentence(rand(30..50)))
end
puts "50 fake room offers generated."

index = Room.all.map{|room| room.id}
puts "Preparing fake reservations..."
status_list = ['paid', 'in_progress', 'cancelled']

5.times do
  index.each do |i|
    duration = rand(1..29)
    ending_date = Faker::Date.between(rand(1..100).days.ago, Date.today)
    starting_date = ending_date - duration.days
    Reservation.create!(guest_id: User.all.sample.id,
    room_id: Room.all.sample.id,
    nb_bed_rented: rand(1..5),
    ending_date: ending_date,
    starting_date: starting_date,
    status: status_list.sample
    )
  end
end
puts '5 anterior reservations generated per room'

5.times do
  index.each do |i|
    duration = rand(1..29)
    starting_date = Faker::Date.between(Date.today,1.year.from_now)
    ending_date = starting_date + duration.days
    Reservation.create!(guest_id: User.all.sample.id,
    room_id: Room.all.sample.id,
    nb_bed_rented: rand(1..5),
    ending_date: ending_date,
    starting_date: starting_date,
    status: status_list.sample
    )
  end
end
puts "5 ulterior reservations generated per room"

100.times do
  PrivateMessage.create!(
  sender_id: User.all.sample.id,
  content: Faker::Lorem.sentence)
end
puts "100 msg generated"


messages = PrivateMessage.all.map{|msg| msg.id}
msg_status_list = ['seen', 'unseen']

3.times do
  messages.each do |msg|
    JoinTableMessageRecipient.create!(
    private_message_id: PrivateMessage.all.sample.id,
    recipient_id: User.all.sample.id,
    status: msg_status_list.sample
    )
  end
end
puts "3 recipients per msg generated"
