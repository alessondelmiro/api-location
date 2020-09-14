FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { '12341234' }
    before(:create) do |user|
      user.address = build(:address)
    end
  end
end