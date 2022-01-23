class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def index
    @message = Message.all.order created_at: :desc
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :message, :email)
  end
end
