FactoryBot.define do
  factory :general_evaluation do
    avg_rating { Faker::Number.decimal_part(digits: 2) }
    one_star { Faker::Number.number(digits: 5) }
    two_stars { Faker::Number.number(digits: 5) }
    three_stars { Faker::Number.number(digits: 5) }
    four_stars { Faker::Number.number(digits: 5) }
    five_stars { Faker::Number.number(digits: 5) }
    location
  end
end