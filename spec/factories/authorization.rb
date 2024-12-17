FactoryBot.define do
  factory :authorization do
    uid { "unique_uid" }
    provider { "provider_name" }
    admin factory: [:user]
  end
end
