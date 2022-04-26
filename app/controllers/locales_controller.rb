# frozen_string_literal: true

class LocalesController < ApplicationController
  def update
    session[:locale] = params[:id]
    redirect_back(fallback_location: '/')
  end
end
