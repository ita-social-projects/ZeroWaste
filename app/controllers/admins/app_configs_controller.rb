# frozen_string_literal: true

module Admins
class AppConfigsController < BaseController
  before_action :config

  def show; end
  def edit; end
  def update; end

  private

  def allow_forgery_protection; end

  def config
    AppConfig.instance
  end
end
end