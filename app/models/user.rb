# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :current_password, :skip_password_validation

  has_paper_trail ignore: %i[current_sign_in_at last_sign_in_at confirmation_token encrypted_password]
  has_one_attached :avatar
  # validate :correct_image_type

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :confirmable, :async,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       confirmation: true,
                       length: { in: 8..64 },
                       format: { with: %r{[-!$%^&*()_+|~=`{}\[\]:";'<>?,./\w]{8,}} },
                       unless: :skip_password_validation
  # validates :password_confirmation, presence: true
  validates :first_name, :last_name, presence: true,
                                     length: { minimum: 2 },
                                     on: %i[create update],
                                     format: { with: /[a-zA-Zа-їА-ЯЄІЇ]+-?'?`?/ }

  validates :avatar, content_type: { in: [:png, :jpg, :jpeg], message: 'must be in PNG or JPG or JPEG format'},
            size: { less_than: 2.megabytes , message: 'size must be less then 2Mb' }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
    end
  end

  def active?
    !blocked?
  end

  def active_for_authentication?
    active? && super
  end

  def inactive_message
    active? ? super : :locked
  end

  def password_required?
    return false if skip_password_validation

    super
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
