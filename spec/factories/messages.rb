# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  message    :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :message do
    title { 'title' }
    email { 'test@test.com' }
    message { 'sometext_sometext_sometext_sometext_' }
  end
end
