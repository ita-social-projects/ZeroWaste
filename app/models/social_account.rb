belongs_to :user
belongs_to :authentication_provider

scope :get_provider_account , -> (user_id,auth_provider_id) { where("user_id = ? and authentication_provider_id = ? ",user_id,auth_provider_id) }
scope :get_provider_name_account , -> (user_id,auth_provider_name) { where("user_id = ? and authentication_providers.name = ? ",user_id,auth_provider_name).joins(:authentication_provider) }

