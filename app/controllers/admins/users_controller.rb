# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render404
    layout 'admin'
    before_action :user, except: [:index]

    def index
      @users = User.all
      respond_to do |format|
        format.html
        format.csv do
          UserReportJob.perform_later
          send_data UsersCsvGenerator.call(@users,
                                           fields: %w[email last_sign_in_at])
        end
      end
    end

    def update
      if user.update(user_params)
        redirect_to admins_user_path(user)
      else
        render 'edit'
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :country, :password,:password_confirmation, :blocked, :avatar).merge(skip_password: true)
    end

    def user
      @user ||= User.find(params[:id])
    end

    def render404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
