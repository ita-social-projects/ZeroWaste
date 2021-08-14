# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    layout 'admin'

    def index
      @users = User.all
    end
  end
end
