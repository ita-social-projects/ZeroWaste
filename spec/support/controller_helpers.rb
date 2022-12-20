module ControllerHelpers
  def sign_in(admin)
    if admin.nil?
      allow(request.env["warden"]).to receive(:authenticate!).and_throw(:warden, { scope: :admin })
      allow(controller).to receive(:current_admin).and_return(nil)
    else
      allow(request.env["warden"]).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
  end
end
