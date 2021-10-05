# frozen_string_literal: true

module Admins
  class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render404
    layout 'admin'
    before_action :find_user, except: [:index]

    def index
      @users = User.all
    end

    def edit
      @user = User.find(params[:id])
      render 'edit'
    end

    def update
      @user = User.find(params[:id])
      if @user.update(params[:user].permit(:first_name, :last_name, :email,
                                           :country))
        redirect_to edit_admins_user_url, notice: 'Successfully Updated'
      else
        render 'edit'
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
