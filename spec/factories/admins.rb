FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "simple_#{n}@admin.com" }
    password { 'admin12345' }
  end
end
