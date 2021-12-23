# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :skip_password
  has_one_attached :image
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: %i[google_oauth2]
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 6, maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       length: { minimum: 8 },
                       format: { with: %r{[-!$%^&*()_+|~=`{}\[\]:";'<>?,./\w]{8,}} },
                       unless: :skip_password
  validates :first_name, :last_name, presence: true,
                                     length: { minimum: 2 },
                                     on: %i[create update],
                                     format: { with: /[a-zA-Zа-їА-ЯЄІЇ]+-?'?`?/ }
  validate :acceptable_image_type?
  validate :acceptable_image_size?

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

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.google_oauth2']) &&
         session['devise.google_oauth2_data']['extra']['raw_info']
        user.email = data['email']
      end
    end
  end

  def displayed_image
    if image.attached?
      image.variant(resize: '150x150!').processed
    else
      '/default_avatar.png'
    end
  end

  def acceptable_image_type?
    return unless image.attached?
    return if image.content_type.in? ["image/png", "image/jpeg"]
    errors.add :image, "must be a PNG or JPG"
  end

  def acceptable_image_size?
    return unless image.attached?
    return unless image.byte_size > 1.megabyte
    errors.add :image, "is over 1MB"
  end
end
