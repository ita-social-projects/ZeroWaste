# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    title { 'title' }
    email { 'test@test.com' }
    message { 'sometext_sometext_sometext_sometext_' }
  end
end
