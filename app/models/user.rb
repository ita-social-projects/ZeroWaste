# frozen_string_literal: true

class User < ApplicationRecord
  include OmniauthAttributesConcern

  has_many :user_authentications

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  devise :omniauthable, omniauth_providers: %i[facebook]
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

  def self.create_from_omniauth(params)
    send(params.provider, params)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
    end

    name_split = auth.info.name.split
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid,
                          last_name: name_split[0], first_name: name_split[1],
                          email: auth.info.email,
                          password: Devise.friendly_token[0, 20])
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.google_oauth2']) &&
         session['devise.google_oauth2_data']['extra']['raw_info']
        user.email = data['email']
      end
    end
  end
end
