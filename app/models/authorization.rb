# frozen_string_literal: true

class Authorization < ApplicationRecord
  # include Encryptable
  # attr_encrypted :token, :secret, :refresh_token

  belongs_to :admin, class_name: "User", foreign_key: "uid", optional: true, inverse_of: :authorizations

  validates :uid, uniqueness: { scope: :provider }
end
