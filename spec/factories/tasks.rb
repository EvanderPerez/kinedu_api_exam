FactoryBot.define do
  factory :task do
    name          { Faker::Lorem.sentence }
    description   { Faker::Lorem.paragraph_by_chars }
    status        {}
  end
end
