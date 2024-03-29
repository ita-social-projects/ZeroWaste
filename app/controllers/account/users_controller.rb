# frozen_string_literal: true

class Account::UsersController < Account::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  layout "account"

  before_action :set_paper_trail_whodunnit
  before_action :user, except: [:index]

  load_and_authorize_resource

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv do
        UserReportJob.perform_later
        send_data UsersCsvGenerator.call(@users, fields: ["email", "last_sign_in_at"])
      end
    end
  end

  def update
    if user.update(user_params)
      redirect_to account_user_path(id: user)
    else
      render "edit"
    end
  end

  private

  def user_params
    prms = params.require(:user).permit(
      :first_name, :last_name, :country, :password, :password_confirmation,
      :blocked, :avatar
    )

    if prms[:password].blank? || prms[:password_confirmation].blank?
      prms = prms.merge(skip_password_validation: true)
    end

    prms
  end

  def user
    @user ||= User.find(params[:id])
  end

  def render404
    render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
  end
end
