# frozen_string_literal: true

module User
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in

    # POST /resource/sign_in

    def create
      user = User.find_by_email(params[:email])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to after_sign_in_path_for(user)
      else
        flash.now.alert = 'Неправильний логін або пароль'
      end
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
