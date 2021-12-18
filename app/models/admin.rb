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
                       length: { minimum: 8 },
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
end
