# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def send_devise_notification(notification, *args)
      UserMailer.send(notification, self, *args).deliver_later
    end
    
    def edit; end

    def update
      updated = if pass_params[:current_password].present?
        current_user.update_with_password(pass_params)   
      else
        current_user.update_without_password(pass_params)
      end

      if updated
        redirect_to root_path, notice: I18n.t('activerecord.attributes.user.successful_update')
      else
        render :edit
      end
    end

    protected

    def after_inactive_sign_up_path_for(_)
      new_user_session_path
    end

    private

    def pass_params
      parameters = params.require(:user)
        .permit(:email, 
                :first_name, 
                :last_name, 
                :country, 
                :current_password, 
                :password, 
                :password_confirmation)
      parameters.compact_blank
    end
  end
end
