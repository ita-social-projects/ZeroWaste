# frozen_string_literal: true

require "rails_helper"

describe "navigator", js: true do
  let :log_as_admin do
    @admin = create(:user, :admin)
    login_as(@admin, scope: :user)
    visit root_path

    expect(page).to have_content("LOG OUT")
  end

  let :log_as_user do
    @user = create(:user)
    login_as(@user, scope: :user)
    visit root_path
  end

  let :enable_admin do
    Flipper.enable :access_admin_menu
  end

  let :disable_admin do
    Flipper.disable :access_admin_menu
  end

  it "should style the navbar" do
    visit root_path

    expect(page).to have_css(".page-header")
    expect(page.body).to have_css(".tabs")
  end

  context "when feature show_admin_menu does not exist" do
    it "should consist tabs without log in" do
      visit root_path

      expect(page).to have_content("SIGN UP")
      expect(page).to have_content("LOG IN")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end

    it "should consist tabs with log in as user" do
      log_as_admin

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end

    it "should consist tabs with log in as admin" do
      log_as_admin

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end

  context "when feature show_admin_menu is disabled" do
    it "should consist tabs as admin" do
      disable_admin
      log_as_admin

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end

    it "should consist tabs as user" do
      disable_admin
      log_as_user

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end

  context "when feature show_admin_menu is enabled" do
    it "should consist ADMIN tab as admin" do
      enable_admin
      log_as_admin

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")
      expect(page).to have_content("ADMIN")
    end

    it "should not consist ADMIN tab as user" do
      enable_admin
      log_as_user

      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end
end
