class Api::V2::ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Devise::Controllers::Helpers
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  include I18nExtended

  prepend_before_action :set_i18n_locale_from_params

  private

  def set_i18n_locale_from_params
    I18n.locale = params[:locale].to_sym if params[:locale].present?
  end
end
