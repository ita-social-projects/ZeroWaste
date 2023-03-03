RSpec.shared_context :update_site_setting do
  before do
    site_setting.update(site_setting_params)
  end
end
