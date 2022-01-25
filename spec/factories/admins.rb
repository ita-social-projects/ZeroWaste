FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin@zw.com" }
    password { 'ChangeMe1' }
  end
end
