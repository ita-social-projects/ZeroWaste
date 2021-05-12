# frozen_string_literal: true

class AdminController < ApplicationController
  layout 'admin'

  def index
    @users = User.all
  end
end
