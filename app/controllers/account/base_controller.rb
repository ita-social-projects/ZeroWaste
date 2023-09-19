# frozen_string_literal: true

class Account::BaseController < ApplicationController
  layout "account"

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end

  rescue_from ActiveRecord::StatementInvalid, ActiveRecord::UnknownAttributeReference do |exception|
    redirect_back(fallback_location: root_path, alert: I18n.t("sort.sort_error"))
  end
end
