# frozen_string_literal: true

class Account::UsersController < Account::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  layout "account"

  before_action :set_paper_trail_whodunnit
  before_action :user, except: [:index, :new, :create]

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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(confirmed_at: DateTime.current))

    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now if user_params[:send_credentials_email]
      redirect_to account_user_path(id: @user), notice: t("notifications.user_created")
    else
      render "new"
    end
  end

  def update
    update_user_params = user_params

    if update_user_params[:password].blank? || update_user_params[:password_confirmation].blank?
      update_user_params = update_user_params.merge(skip_password_validation: true)
    end

    if user.update(update_user_params)
      redirect_to account_user_path(id: user), notice: t("notifications.user_updated")
    else
      render "edit"
    end
  end

  def destroy
    user.destroy
    redirect_to account_users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :first_name, :last_name, :country, :role, :password, :password_confirmation,
      :blocked, :avatar, :send_credentials_email
    )
  end

  def user
    @user ||= User.find(params[:id])
  end

  def render404
    render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
  end
end
