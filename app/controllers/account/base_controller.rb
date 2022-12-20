# frozen_string_literal: true

class Account::BaseController < ApplicationController
  layout "account"

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end
end
