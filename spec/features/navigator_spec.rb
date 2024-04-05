# frozen_string_literal: true

require "rails_helper"

describe "navigator", js: true do
  it "should style the navbar" do
    visit root_path

    expect(page).to have_css(".page-header")
    # expect(page).to have_link("Log In", href: user_session_path, visible: :all)
    # expect(page).to have_link("Sign Up", href: new_user_registration_path, visible: :all)
    expect(page).to have_link("Contact us", href: new_message_path, visible: :all)
  end

  context "as an admin user" do
    include_context :authorize_admin

    before { visit root_path }

    it "should consist tabs" do
      expect(page).to have_link("Log Out", href: destroy_user_session_path, visible: :all)
      expect(page).to have_link("Contact us", href: new_message_path, visible: :all)
      expect(page).to have_link("Admin", href: account_calculators_path, visible: :all)
    end
  end

  context "as an regular user" do
    include_context :authorize_regular_user

    before { visit root_path }

    it "should consist tabs" do
      expect(page).to have_link("Log Out", href: destroy_user_session_path, visible: :all)
      expect(page).to have_link("Contact us", href: new_message_path, visible: :all)
      expect(page).to have_no_link("Admin", href: account_calculators_path, visible: :all)
    end
  end
end
