# frozen_string_literal: true

require "rails_helper"

describe "visit Login page", js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }

  include_context :enable_calculators_constructor

  it "when sign in with correct login and password" do
    allow_any_instance_of(ApplicationController)
      .to receive(:after_sign_in_path_for)
      .and_return("/calculators/#{calculator.slug}")
    allow(Devise::Mailer).to receive(:confirmation_instructions)
      .and_return(double(deliver: true))
    create(:feature_flag, :show_admin_menu)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_link_or_button "Log In"
    sleep 2
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_link("Log Out", href: destroy_user_session_path, visible: :all)
  end
end
