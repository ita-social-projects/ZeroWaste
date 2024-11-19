# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  blocked                :boolean          default(FALSE), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  country                :string
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  provider               :string
#  receive_recomendations :boolean          default(FALSE), not null
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
require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "associations" do
    it { is_expected.to have_one_attached(:avatar) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:email).is_at_least(6) }
    it { is_expected.to validate_length_of(:email).is_at_most(100) }

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to validate_length_of(:password).is_at_most(64) }

    it { is_expected.to validate_presence_of(:first_name).on(:create) }
    it { is_expected.to validate_presence_of(:first_name).on(:update) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(50).on(:create) }
    it { is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(50).on(:update) }

    it { is_expected.to validate_presence_of(:last_name).on(:create) }
    it { is_expected.to validate_presence_of(:last_name).on(:update) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(50).on(:create) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(50).on(:update) }

    it { is_expected.to allow_value("email@gmail.com").for(:email) }
    it { is_expected.not_to allow_value("email.factory-com").for(:email) }
    it { is_expected.to allow_value("ddc5+/8/555/dd").for(:password) }
    it { is_expected.to allow_value("P@$$w0rd!-_%^&*()_+|~={}[]:\";'<>?,./").for(:password) }
    it { is_expected.not_to allow_value("/asd").for(:password) }
  end

  describe "versioning", versioning: true do
    let!(:user) { create(:user, first_name: "John", last_name: "Doe") }

    it "adds a version when the user is updated" do
      user.update!(first_name: "Jane", last_name: "Doe")

      expect(user.versions.count).to eq(2)
    end
  end

  describe ".grouped_collection_by_role" do
    let!(:admin) { create(:user, :admin) }
    let!(:regular_user) { create(:user) }

    subject { described_class.grouped_collection_by_role.to_h }

    it "returns a hash with the users grouped by role" do
      expect(subject.keys).to match_array(["admin", "user"])
      expect(subject.values.flatten).to match_array([admin, regular_user])
    end
  end

  describe ".from_omniauth" do
    context "when the user exists" do
      let(:user) { create(:user) }
      let(:access_token) do
        double(
          "access_token",
          info: {
            "email" => user.email
          }
        )
      end

      it "returns the user" do
        expect(described_class.from_omniauth(access_token)).to eq(user)
      end
    end

    context "when the user does not exist" do
      let(:access_token) do
        double(
          "access_token",
          info: {
            "first_name" => "John",
            "last_name" => "Doe",
            "email" => "example@mail.io"
          }
        )
      end

      it "creates a new user" do
        expect do
          described_class.from_omniauth(access_token)
        end.to change(described_class, :count).by(1)
      end
    end
  end
end
