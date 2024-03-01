# frozen_string_literal: true

require "rails_helper"

describe "navigator", js: true do
  it "should style the navbar" do
    visit root_path

    expect(page).to have_css(".page-header")
    expect(page).to have_link("Log In", href: "/en/users/sign_in", visible: :all)
    expect(page).to have_link("Sign Up", href: "/en/sign_up", visible: :all)
    expect(page).to have_link("Contact us", href: "/en/messages/new", visible: :all)
  end

  context "as an admin user" do
    include_context :authorize_admin

    before { visit root_path }

    it "should consist tabs" do
      expect(page).to have_link("Log Out", href: "/en/users/sign_out", visible: :all)
      expect(page).to have_link("Contact us", href: "/en/messages/new", visible: :all)
      expect(page).to have_link("Admin", href: "/en/account/calculators", visible: :all)
    end
  end

  context "as an regular user" do
    include_context :authorize_regular_user

    before { visit root_path }

    it "should consist tabs" do
      expect(page).to have_link("Log Out", href: "/en/users/sign_out", visible: :all)
      expect(page).to have_link("Contact us", href: "/en/messages/new", visible: :all)
      expect(page).to have_no_link("Admin", href: "/en/accounts/calculators", visible: :all)
    end
  end
end
