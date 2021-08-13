# frozen_string_literal: true

module User
  class RegistrationsController < Devise::RegistrationsController
    # Override the action you want here.
    protect_from_forgery with: :exception
    before_action :sign_up_params

    private

    def sign_up_params
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[first_name last_name country])
    end

    def after_inactive_sign_up_path_for(_)
      new_user_session_path
    end
  end
end
