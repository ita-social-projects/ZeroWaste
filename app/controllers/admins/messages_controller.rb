module Admins
  class MessagesController < ApplicationController
    layout 'admin'
    rescue_from ActiveRecord::RecordNotFound, with: :render404

    def index
      @message = Message.all.order created_at: :desc
    end

    def show
      @message ||= Message.find(params[:id])
    end

   private

    def message_params
      params.require(:message).permit(:title, :message, :email)
    end

    def render404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
