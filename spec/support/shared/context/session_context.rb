RSpec.shared_context :authorize_admin do
  let(:current_user) { create(:user, :admin) }

  before { sign_in current_user }
end
