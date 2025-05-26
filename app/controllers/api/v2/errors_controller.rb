class Api::V2::ErrorsController < ActionController::API
  def invalid_locale
    render json: { error: "Locale not supported" }, status: :bad_request
  end
end
