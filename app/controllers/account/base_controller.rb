# frozen_string_literal: true

class Account::BaseController < ApplicationController
  layout "account"

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
    end
  end


  private

  def render_404
    render "errors/admin_404", status: :not_found, layout: "account"
  end
end
