# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def send_devise_notification(notification, *args)
      UserMailer.send(notification, self, *args).deliver_later
    end
    
    protected

    def after_inactive_sign_up_path_for(_)
      new_user_session_path
    end
  end
end
