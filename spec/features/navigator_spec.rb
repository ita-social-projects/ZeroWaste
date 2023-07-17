# frozen_string_literal: true

require "rails_helper"

describe "navigator", js: true do
  @admin = create(:user, :admin)
  
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

    it "should consist tabs with log in" do
      sign_in @admin
    
      visit root_path
      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end

  # context "when feature show_admin_menu is disabled" do
  #   it "should not consist tabs" do
  #     create(:feature_flag, :hide_admin_menu)
  #     visit root_path
  #     expect(page).not_to have_content("SIGN UP")
  #     expect(page).not_to have_content("LOG IN")
  #     expect(page).not_to have_content("CONTACT US")
  #   end
  # end

  # context "when feature show_admin_menu is enabled" do
  #   it "should consist tabs" do
  #     create(:feature_flag, :show_admin_menu)
  #     visit root_path
  #     expect(page).to have_content("SIGN UP")
  #     expect(page).to have_content("LOG IN")
  #     expect(page).to have_content("CONTACT US")
  #   end
  # end
end
