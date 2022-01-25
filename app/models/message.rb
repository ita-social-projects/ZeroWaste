class Message < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates :message, presence: true, length: { minimum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def created_at_mod
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
