# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_inactive_sign_up_path_for(_)
      new_user_session_path
    end
  end
end
