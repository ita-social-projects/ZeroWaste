class Authorization < ApplicationRecord
  # include Encryptable
  # attr_encrypted :token, :secret, :refresh_token

  belongs_to :admin, optional: true
  validates_uniqueness_of :uid, scope: [:provider]
end
