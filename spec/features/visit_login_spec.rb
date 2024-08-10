# frozen_string_literal: true

require "rails_helper"

describe "visit Login page", js: true do
  let(:user) { create(:user) }

  it "when sign in with correct login and password" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_link("Log Out", href: destroy_user_session_path, visible: :all)
  end
end
