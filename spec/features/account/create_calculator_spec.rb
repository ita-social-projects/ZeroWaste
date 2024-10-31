# frozen_string_literal: true

require "rails_helper"

describe "Create Calculator Page", js: true do
  let(:calculator) { create(:calculator) }
  let(:create_calrulator_button) { "Create calculator" }

  include_context :authorize_admin

  before do
    visit new_account_calculator_path
  end

  context "when user clicks button Create calculator" do
    it "shows message that calculator has been successfully created" do
      fill_in "Name", with: "Calculator1"
      click_link_or_button create_calrulator_button
      sleep 1
      expect(page).to have_content("Calculator has been successfully created")
    end
  end

  context "when user clicks button Create calculator" do
    it "redirects to Index calculator page" do
      fill_in "Name", with: "Calculator2"
      click_link_or_button create_calrulator_button
      expect(page).to have_current_path(account_calculators_path)
    end
  end

  context "when user fill in the Name field with name that already exist" do
    it "shows message that name is already has been taken" do
      fill_in "Name", with: calculator.name
      click_link_or_button create_calrulator_button
      sleep 2
      expect(page).to have_content("Name has already been taken")
    end
  end

  context "when user fill in the Name field with name shorter than 2 symbols" do
    it "shows message that name is too short" do
      fill_in "Name", with: "i"
      click_link_or_button create_calrulator_button
      sleep 2
      expect(page).to have_content("Name is too short (minimum is 2 characters)")
    end
  end

  context "when user fill in the Name field with symbols" do
    it "shows message that name is invalid" do
      fill_in "Name", with: "i[]p"
      click_link_or_button create_calrulator_button
      expect(page).to have_content("Name contains invalid characters")
    end
  end

  context "when user left the Name field blank" do
    it "shows message that name can't be blank" do
      fill_in "Name", with: ""
      click_link_or_button create_calrulator_button
      sleep 2
      expect(page).to have_content("Name can't be blank")
    end
  end
end
