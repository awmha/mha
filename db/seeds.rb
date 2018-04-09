User.create!(name:  "Test User", email: "test@email.com", password: "password_test", password_confirmation: "password_test", admin: true, activated: true, activated_at: Time.zone.now)

5.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
3.times do
  name = Faker::Lorem.words(3)
  city = Faker::Address.city
  state = Faker::Address.state_abbr
  location = city + ", " + state
  users.each { |user| user.projects.create!(name: name.to_sentence.titleize.gsub(",",''), location: location) }
end