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
require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:user) }
  describe 'validations' do
    it {
      is_expected.to validate_presence_of(:email)
    }
    it {
      is_expected.to validate_uniqueness_of(:email).case_insensitive
    }
    it {
      is_expected.to validate_length_of(:email).is_at_least(6)
    }
    it {
      is_expected.to validate_length_of(:email).is_at_most(100)
    }
    it {
      is_expected.to allow_value('email@gmail.com').for(:email)
    }
    it {
      is_expected.not_to allow_value('email.factory-com').for(:email)
    }
    it {
      is_expected.to allow_value('ddc5+/8/555/dd').for(:password)
    }
    it {
      is_expected.not_to allow_value('/asd').for(:password)
    }
    it {
      is_expected.to validate_length_of(:password).is_at_least(8)
    }
  end
end
