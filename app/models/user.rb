# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
end
