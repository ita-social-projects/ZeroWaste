# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable
  validates :email, presence: true,
                    #acceptance: { message: 'Невірний логін'},
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                     #acceptance: { message: 'Невірний пароль'},
                     length: { minimum: 8 },
                     format: { with: /[-!$%^&*()_+|~=`{}\[\]:";'<>?,.\/\w]{8,}/ }
end
