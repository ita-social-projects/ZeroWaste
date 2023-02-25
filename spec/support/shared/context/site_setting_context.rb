RSpec.shared_context :with_authenticated_admin do
  before do
    @admin = create(:user, :admin)
    sign_in @admin
  end
end

RSpec.shared_context :with_authenticated_user do
  before do
    @user = create(:user)
    sign_in @user
  end
end

RSpec.shared_context :update_site_setting do
  before do
    site_setting.update(site_setting_params)
  end
end
