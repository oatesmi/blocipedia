require 'faker'

#create standard user
5.times do
  User.create!(
    username: Faker::Internet.user_name(3..15),
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password(6),
    role: 'standard'
  )
end
users = User.all

#create wikis
10.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::RickAndMorty.location,
    body: Faker::RickAndMorty.quote,
    private: false
  )
end
wikis = Wiki.all

premium_user = User.create!(
  username: 'PremiumUser',
  email: 'premiumuser@example.com',
  password: 'password',
  role: 'premium'
)

admin_user = User.create!(
  username: 'AdminUser',
  email: 'adminuser@example.com',
  password: 'password',
  role: 'admin'
)

test_user = User.create!(
  username: 'Mike',
  email: 'oatesmi.74@gmail.com',
  password: 'password',
  role: 'standard'
)

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
