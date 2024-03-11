class ErrorsController < ApplicationController
  def not_found
    if request.path.include?("/en/account/") || request.path.include?("/uk/account/")
      render "errors/admin_404", status: :not_found, layout: "account"
    else
      render "errors/public_404", status: :not_found, layout: "application"
    end
  end
end
