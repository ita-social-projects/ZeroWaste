# frozen_string_literal: true

require "rails_helper"

describe "visit Login page", js: true do
  let(:user) { create(:user) }

  it "when sign in with correct login and password" do
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("LOG OUT")
  end
end
