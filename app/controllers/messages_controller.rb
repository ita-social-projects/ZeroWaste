# frozen_string_literal: true

class MessagesController < ApplicationController
  def new
    @message = Message.new
    add_breadcrumb t("breadcrumbs.home"), root_path
    add_breadcrumb t(".contact_us_header")
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to root_path, notice: t("notifications.message_sent")
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :message, :email)
  end
end
