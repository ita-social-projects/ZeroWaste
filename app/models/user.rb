# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :confirmable

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: { with: %r{[-!$%^&*()_+|~=`{}\[\]:";'<>?,./\w]{8,}}i }
  validates :first_name, :last_name, presence: true,
                                     on: :create,
                                     length: { minimum: 2 },
                                     format: { with: /[a-zA-Zа-їА-ЯҐЄІЇ]+-?`?'?/ }
end
