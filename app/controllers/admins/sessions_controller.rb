# frozen_string_literal: true

module Admins
  class SessionsController < Devise::SessionsController
    layout 'admin'
    before_action :check_user

    protected

    def check_user
      return if current_admin

      flash.clear
      redirect_to('/admins/users')

    end
    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #  super
    # end

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
