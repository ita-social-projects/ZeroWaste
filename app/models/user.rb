# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  blocked                :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country                :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  provider               :string
#  receive_recomendations :boolean          default(FALSE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("user")
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  attr_accessor :current_password, :skip_password_validation, :send_credentials_email

  scope :ordered_by_email, -> { order(:email) }
  scope :ordered_by_first_name, -> { order(:first_name) }
  scope :ordered_by_last_name, -> { order(:last_name) }

  has_paper_trail ignore: [
    :current_sign_in_at, :last_sign_in_at, :confirmation_token,
    :encrypted_password
  ]

  has_one_attached :avatar

  enum role: {
    admin: 1,
    user: 0
  }

  def self.grouped_collection_by_role
    User.all.group_by(&:role).map { |key, value| [key, value.take(2)] }.sort
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :confirmable, :lockable, :timeoutable, :trackable, :async,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, allow_blank: true, length: { minimum: 6, maximum: 100 }
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, unless: :skip_password_validation
  validates :password,
            allow_blank: true,
            confirmation: true,
            length: { in: 8..64 },
            unless: :skip_password_validation
  validates :password,
            allow_blank: true,
            confirmation: true,
            format: { with: %r{[-!$%^&*()_+|~=`{}\[\]:";'<>?,./\w]{8,}} },
            unless: :skip_password_validation
  validates :first_name, :last_name, presence: true, on: [:create, :update]
  validates :first_name, :last_name,
            allow_blank: true,
            on: [:create, :update],
            length: { in: 2..50 }
  validates :first_name, :last_name,
            allow_blank: true,
            on: [:create, :update],
            format: { with: /[a-zA-Zа-їА-ЯЄІЇ]+-?'?`?/ }

  validates :avatar, content_type: ["image/png", "image/jpeg", "image/jpg"],
                     size: { less_than: 2.megabytes }

  def self.from_omniauth(access_token)
    data       = access_token.info
    user       = User.where(email: data["email"]).first
    split_name = data["name"].split
    user     ||= User.create(first_name: data["first_name"] || split_name[0],
                             last_name: data["last_name"] || split_name[1],
                             email: data["email"],
                             confirmed_at: Time.zone.now,
                             password: Devise.friendly_token[0, 20])
    user
  end

  def active?
    !blocked?
  end

  def admin?
    role == "admin"
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
      if (data = session["devise.google_oauth2"]) &&
          session["devise.google_oauth2_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def full_name
    [first_name, last_name].compact_blank.join(" ")
  end
end
