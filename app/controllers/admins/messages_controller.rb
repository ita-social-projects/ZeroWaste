# frozen_string_literal: true

module Admins
  class MessagesController < BaseController
    load_and_authorize_resource
    def index
      @message = Message.order(created_at: :desc)
    end

    def show
      @message = Message.find(params[:id])
    end
  end
end
