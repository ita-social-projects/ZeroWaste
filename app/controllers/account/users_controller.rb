# frozen_string_literal: true

class Account::UsersController < Account::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  layout "account"

  before_action :set_paper_trail_whodunnit

  load_and_authorize_resource

  def index
    @q     = collection.ransack(params[:q])
    @users = @q.result

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
    @user = User.new(user_params)

    @user.skip_confirmation!

    if @user.save
      UserMailer.welcome_email(@user).deliver_now if user_params[:send_credentials_email] == "1"

      redirect_to account_user_path(id: @user), notice: t("notifications.user_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = resource

    if @user.update(user_params)
      redirect_to account_user_path(id: @user), notice: t("notifications.user_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy

    redirect_to account_users_path
  end

  private

  def user_params
    prms = params.require(:user).permit(
      :email, :first_name, :last_name, :country, :role, :password, :password_confirmation,
      :blocked, :avatar, :send_credentials_email
    )

    if action_name == "update" && (prms[:password].blank? || prms[:password_confirmation].blank?)
      prms = prms.merge(skip_password_validation: true)
    end

    prms
  end

  def collection
    User.ordered_by_email
  end

  def resource
    User.find(params[:id])
  end

  def render404
    render file: Rails.public_path.join("404.html"), layout: false, status: :not_found
  end
end
