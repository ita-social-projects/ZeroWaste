# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  country                :string
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  provider               :string
#  uid                    :string
#  blocked                :boolean          default(FALSE)
#  role                   :integer          default("user")
#  receive_recomendations :boolean          default(FALSE)
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
