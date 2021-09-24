# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable

  devise :omniauthable, omniauth_providers: %i[facebook]
  devise :omniauthable, omniauth_providers: %i[facebook2]
  def self.from_omniauth(auth)
    name_split = auth.info.name.split
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid,
                          last_name: name_split[0], first_name: name_split[1],
                          email: auth.info.email,
                          password: Devise.friendly_token[0, 20])
    user
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook]
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: { with: %r{[-!$%^&*()_+|~=`{}\[\]:";'<>?,./\w]{8,}} }
  validates :first_name, :last_name, presence: true,
                                     length: { minimum: 2 },
                                     on: :create,
                                     format: { with: /[a-zA-Zа-їА-ЯЄІЇ]+-?'?`?/ }
end
