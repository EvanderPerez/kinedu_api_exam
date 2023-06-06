FactoryBot.define do
  factory :task do
    name          { Faker::Lorem.sentence }
    description   { Faker::Lorem.paragraph_by_chars }
    status        {}
    created_by    { create(:user) }
  end
end
