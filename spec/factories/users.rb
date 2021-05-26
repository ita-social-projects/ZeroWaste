FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Internet.first_name }
    last_name { Faker::Internet.last_name }
    country { Faker::Address.country}
  end
end
