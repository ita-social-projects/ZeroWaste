class Api::V2::SessionsController < Devise::SessionsController
  respond_to :json

  skip_before_action :verify_authenticity_token

  private

  def respond_with(user, _opts = {})
    token = request.env['warden-jwt_auth.token']
    render json: { user: user.email, token: token }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end
end
