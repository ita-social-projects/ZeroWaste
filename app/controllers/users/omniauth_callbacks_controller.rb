# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def failure
      redirect_to root_path
    end

    def google_oauth2
      authorization('Google')
    end

    def facebook
      authorization('Facebook')
    end

    def authorization(kind)
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        flash[:notice] =
          I18n.t 'devise.omniauth_callbacks.success', kind: kind
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] =
          request.env['omniauth.auth'].except('extra')
        redirect_to new_user_registration_url,
                    alert: @user.errors.full_messages.join("\n")
      end
    end
  end
end
