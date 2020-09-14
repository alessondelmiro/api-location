FactoryBot.define do
  factory :evaluation do
    rating { Faker::Number.within(range: 1..5) }
    comment { Faker::Lorem.paragraph }
    location
    user
  end
end