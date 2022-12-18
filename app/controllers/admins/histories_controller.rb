# frozen_string_literal: true

class Admins::HistoriesController < Admins::BaseController
  def index
    raise CanCan::AccessDenied unless current_user.admin?

    @versions = PaperTrail::Version.order("created_at DESC").limit(100)
  end
end
