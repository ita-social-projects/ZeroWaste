RSpec.shared_context :signed_in_user do
  let(:user) { create(:user) }

  before do
    sign_in user
    get account_root_path
  end
end
