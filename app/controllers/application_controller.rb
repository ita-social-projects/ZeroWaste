# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include I18nExtended

  prepend_before_action :set_i18n_locale_from_params
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def redirection
    redirect_to root_url
  end

  private

  def storable_location?
    request.get? && is_navigational_format? &&
      !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  def after_sign_out_path_for(*)
    request.referer
  end

  def after_sign_up_path_for(_)
    new_user_session_path
  end

  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  protected

  def configure_permitted_parameters
    user_attr = [:email, :password, :password_confirmation, :first_name, :last_name, :country]

    devise_parameter_sanitizer.permit(:sign_up, keys: user_attr)
  end
end
