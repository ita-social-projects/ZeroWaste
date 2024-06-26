# frozen_string_literal: true

class Account::HistoriesController < Account::BaseController
  def index
    raise CanCan::AccessDenied unless current_user.admin?

    @versions = PaperTrail::Version.order("created_at DESC").limit(100).page(params[:page])
  end
end
