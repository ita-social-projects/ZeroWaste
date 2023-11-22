# frozen_string_literal: true

require "rails_helper"

describe "sign out", js: true do
  let(:user) { create(:user) }

  flash_message_disappear_time = 20

  before do
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    Capybara.using_wait_time flash_message_disappear_time do
      click_link "Log Out"
      sleep 3
    end
  end

  it "signs the user out" do
    expect(page).to have_content("LOG IN")
  end
end
