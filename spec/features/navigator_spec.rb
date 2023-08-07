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

    before { visit root_path }

    it "should consist tabs" do
      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).to have_content("ADMIN")
    end
  end

  context "as an regular user" do
    include_context :authorize_regular_user

    before { visit root_path }

    it "should consist tabs" do
      expect(page).to have_content("LOG OUT")
      expect(page).to have_content("CONTACT US")

      expect(page).not_to have_content("ADMIN")
    end
  end
end
