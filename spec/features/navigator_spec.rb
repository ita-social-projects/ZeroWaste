# frozen_string_literal: true

require "rails_helper"

describe "navigator", js: true do
  it "should style the navbar" do
    visit root_path

    expect(page).to have_css(".page-header")
    expect(page.body).to have_css(".tabs")

    expect(page).to have_content("LOG IN")
    expect(page).to have_content("SIGN UP")
    expect(page).to have_content("CONTACT US")
  end

  context "as an admin user" do

    include_context :authorize_admin
    include_context :disable_admin_menu

    before { visit root_path}

    it "should consist tabs when feature show_admin_menu is disabled" do
      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end

    include_context :enable_admin_menu
    it "should consist tabs when feature show_admin_menu is enabled" do
      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end

  context "as an regular user" do
    include_context :authorize_regular_user
    include_context :disable_admin_menu

    before { visit root_path}

    it "should consist tabs when feature show_admin_menu is disabled" do
      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end

    include_context :enable_admin_menu
    it "should consist tabs when feature show_admin_menu is enabled" do
      visit root_path

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end
end
