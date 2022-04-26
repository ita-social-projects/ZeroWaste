module Admins
  class MessagesController < BaseController
      
    def index
      @message = Message.order(created_at: :desc)
    end

    def show
      @message ||= Message.find(params[:id])
    end
    
  end
end
