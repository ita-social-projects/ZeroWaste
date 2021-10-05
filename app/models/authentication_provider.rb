# frozen_string_literal: true

has_many :social_accounts
has_many :users
has_many :user_authentications

scope :get_provider_name, ->(provider_name) { where('name = ?', provider_name) }
