# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def send_devise_notification(notification, *args)
    UserMailer.send(notification, self, *args).deliver_later
  end

  def edit
  end

  def update
    update_method_name, usr_params = user_params

    if @user.public_send(:"update_#{update_method_name}", usr_params)
      redirect_to(
        edit_user_registration_path,
        notice: I18n.t("activerecord.attributes.user.successful_update")
      )
    else
      render "devise/registrations/edit"
    end
  end

  protected

  def after_inactive_sign_up_path_for(_)
    new_user_session_path
  end

  private

  def user_params
    prms = params.require(:user).permit(
      :email, :first_name, :last_name,
      :country, :current_password,
      :password, :password_confirmation
    )

    if prms[:password].blank?
      [:without_password, prms.merge(skip_password_validation: true)]
    else
      [:with_password, prms]
    end
  end
end
