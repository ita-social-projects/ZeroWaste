class Api::V2::ApplicationController < ActionController::API
  include I18nExtended

  prepend_before_action :set_i18n_locale_from_params

  private

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
end
