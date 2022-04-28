# frozen_string_literal: true

module Admins
  class BaseController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!
  end
end
