# frozen_string_literal: true

require "rails_helper"

describe "sign out", js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }
  let(:flash_message_disappear_time) { 20 }

  before do
    create(:feature_flag, :show_admin_menu)
    allow_any_instance_of(ApplicationController).to receive(:after_sign_in_path_for).and_return("/calculators/#{calculator.slug}")
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log In"
    page.driver.browser.manage.window.resize_to(1920, 1080)
    Capybara.using_wait_time flash_message_disappear_time do
      click_on "Log Out"
      sleep 3
    end
  end

  xit "signs the user out" do
    expect(page).to have_current_path("/calculators/#{calculator.slug}")
    expect(page).to have_content("LOG IN")
  end
end
