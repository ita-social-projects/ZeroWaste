class Api::V2::ApplicationController < ActionController::API
  include I18nExtended

  prepend_before_action :set_i18n_locale_from_params

  private

  def set_i18n_locale_from_params
    I18n.locale = params[:locale].to_sym if params[:locale]
  end
end
