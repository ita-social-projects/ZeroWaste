# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def send_devise_notification(notification, *args)
      UserMailer.send(notification, self, *args).deliver_later
    end

    def edit; end

    def update
      if @user.update(user_params)
           redirect_to edit_user_registration_path, notice: I18n.t('activerecord.attributes.user.successful_update')
      else
        render 'devise/registrations/edit'
      end
    end

    protected

    def after_inactive_sign_up_path_for(_)
      new_user_session_path
    end

    private

    def user_params
      prms = params.require(:user).permit(:email,
                                   :first_name,
                                   :last_name,
                                   :country,
                                   :current_password,
                                   :password,
                                   :password_confirmation)
      prms = prms.merge(skip_password_validation: true) unless prms[:password].present?
      prms
    end
  end
end
