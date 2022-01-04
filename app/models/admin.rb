# frozen_string_literal: true

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       format: { with: %r{[-!$%^&*()_+|~=`{}\[\]:";'<>?,.\w]{8,}} }

  attr_accessor :current_password

  def update_with_password(params)
    if params[:password].blank?
      errors.add(:password, I18n.t('admins.passwords.password.blank'))
      false
    else
      super
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |admin|
      admin.email = auth.info.email
      admin.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |admin|
      if (data = session['devise.google_oauth2']) &&
        session['devise.google_oauth2_data']['extra']['raw_info']
        admin.email = data['email']
      end
    end
  end
