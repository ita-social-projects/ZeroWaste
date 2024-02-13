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
class Message < ApplicationRecord
  scope :ordered_by_title, -> { order(:title) }

  validates :title, presence: true, length: { minimum: 5 }
  validates :message, presence: true, length: { minimum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "message", "title", "updated_at"]
  end
end
