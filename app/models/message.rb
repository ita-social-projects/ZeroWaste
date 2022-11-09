# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  message    :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Message < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :message, presence: true, length: { minimum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
