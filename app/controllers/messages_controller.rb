class MessagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :message, :email)
  end

  def render404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end
