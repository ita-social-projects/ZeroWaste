# frozen_string_literal: true

module Admins
class AppConfigsController < BaseController
  before_action :config
  load_and_authorize_resource
  
  def update; end

  private

  def allow_forgery_protection; end

  def config
    @config = AppConfig.instance
  end
end
end