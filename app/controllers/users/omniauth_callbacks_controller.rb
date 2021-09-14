# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        if is_navigational_format?
          set_flash_message(:notice, :success,
                            kind: 'Facebook')
        end
      else
        session['devise.facebook_data'] =
          request.env['omniauth.auth'].except(:extra)
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
