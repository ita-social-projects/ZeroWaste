require 'rails_helper'

RSpec.describe 'Feature Flags', type: :feature do
  include_context :authorize_admin

  it 'displays the admin tab when the access_admin_menu feature flag is enabled' do
    feature = Flipper[:access_admin_menu]
    feature.enable

    visit root_path

    expect(page).to have_content('Admin')
  end

  it 'does not display the admin tab when the access_admin_menu feature flag is disabled' do
    feature = Flipper[:access_admin_menu]
    feature.disable

    visit root_path

    expect(page).not_to have_content('Admin')
  end
end
