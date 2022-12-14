# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_user!

    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html { redirect_to root_path, alert: exception.message }
      end
    end
  end
end
