class User::RegistrationsController < Devise::RegistrationsController
  # Override the action you want here.
  protect_from_forgery with: :exception
  before_action :sign_up_params

  private

  def sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name country])
  end
end
