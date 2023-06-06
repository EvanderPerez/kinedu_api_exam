FactoryBot.define do
  factory :user do
    first_name  { Faker::Lorem.word }
    last_name   { Faker::Lorem.word }
    email       { Faker::Internet.email }
    password    { Faker::Internet.password }
  end
end
