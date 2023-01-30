# frozen_string_literal: true

class Account::MessagesController < Account::BaseController
  load_and_authorize_resource

  def index
    @message = Message.order(created_at: :desc)
  end

  def show
    @message = Message.find(params[:id])
  end
end
