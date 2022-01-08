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

  def self.from_omniauth(auth)
    authorization = Authorization.find_by(provider: auth.provider,
                                          uid: auth.uid)
    return authorization.admin if authorization

    email = auth['email']

    # match existing admins
    existing_admin = find_for_database_authentication(email: email.downcase)
    if existing_admin
      existing_admin.add_oauth_authorization(auth).save
      return existing_admin
    end

    create_new_admin_from_oauth(auth, email)
  end

  def self.new_with_session(params, session)
    super.tap do |admin|
      if data = session.dig(:devise.google_oauth2, :devise.google_oauth2_data,
                            :extra, :raw_info)
        admin.email = data['email']
        admin.add_oauth_authorization(data)
      end
    end
  end

  def add_oauth_authorization(data)
    authorizations.build({
                           provider: data['provider'],
                           uid: data['uid'],
                           email: data['email']
                         })
  end
end
