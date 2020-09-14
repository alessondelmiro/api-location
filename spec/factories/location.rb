FactoryBot.define do
  factory :location do
    name { Faker::Movies::HarryPotter.location }
    description { Faker::Lorem.paragraph }
    user
    before(:create) do |location|
      location.address = build(:address)
    end
  end
end