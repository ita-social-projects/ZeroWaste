# frozen_string_literal: true

class Account::MessagesController < Account::BaseController
  load_and_authorize_resource

  def index
    @q          = collection.ransack(params[:q])
    @messages = @q.result
  end

  def show
    @message = resource
  end

  private

  def resource
    collection.find(params[:id])
  end

  def collection
    Message.ordered_by_title
  end
end
