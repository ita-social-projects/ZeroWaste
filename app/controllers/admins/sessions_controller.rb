# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    layout 'admin'
    before_action :current_admin

    protected

    def after_sign_in_path_for(resource)
      admins_users_path
    end
  end
end
