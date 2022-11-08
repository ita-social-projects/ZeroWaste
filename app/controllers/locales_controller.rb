# frozen_string_literal: true

class LocalesController < ApplicationController
  def switch_locale
    session[:locale] = params[:locale]
    I18n.locale = session[:locale] || I18n.default_locale

    redirect_back(fallback_location: '/')
  end
end
