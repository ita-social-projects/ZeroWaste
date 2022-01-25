FactoryBot.define do
  factory :admin do
    sequence(:email) { "admin@zw.com" }
    password { 'ChangeMe1' }
  end
end
