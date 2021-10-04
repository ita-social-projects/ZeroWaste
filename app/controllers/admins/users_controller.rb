# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render404
    layout 'admin'
    before_action :find_user, except: [:index]

    def index
      @users = User.all
      respond_to do |format|
        format.html
        format.csv do
          send_data UsersCsvGenerator.call(@users,
                                           fields: %w[email last_sign_in_at])
        end
      end
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def render404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
