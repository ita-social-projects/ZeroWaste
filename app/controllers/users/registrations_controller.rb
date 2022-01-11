# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def send_devise_notification(notification, *args)
      UserMailer.send(notification, self, *args).deliver_later
    end

    def edit; end

    def update
      if user_params[:password].blank? && user_params[:password_confirmation].blank?
        user_params.delete(:password)
        user_params.delete(:password_confirmation)
        user_params.delete(:current_password)
        @user.update_without_password(user_params)
        redirect_to root_path, notice: I18n.t('activerecord.attributes.user.successful_update')
      else
        super
      end
    end

    protected

    def after_inactive_sign_up_path_for(_)
      new_user_session_path
    end

    private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :country, :current_password, :password,:password_confirmation)
    end
  end
end
