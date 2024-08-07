# frozen_string_literal: true

module I18nExtended
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  private

  def switch_locale(&action)
    locale = params.permit(:locale)[:locale]
    locale = ["uk", "en"].include?(locale.to_s) ? locale : I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    if request.path.include?("account")
      super
    else
      { locale: I18n.locale }
    end
  end
end
