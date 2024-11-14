FactoryBot.define do
  factory :authorization do
    uid { "unique_uid" }
    provider { "provider_name" }
    association :admin, factory: :user
  end
end
