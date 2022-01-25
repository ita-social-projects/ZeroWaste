FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "test1@gmail.com" }
    password { 'ChangeMe1' }
  end
end
