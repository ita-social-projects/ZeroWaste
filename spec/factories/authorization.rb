FactoryBot.define do
  factory :authorization do
    uid { SecureRandom.hex }
    provider { "provider_name" }
    admin factory: [:user]
  end
end
