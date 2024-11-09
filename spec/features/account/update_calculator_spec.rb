# frozen_string_literal: true

require "rails_helper"

describe "Update Calculator Page", js: true do
  let(:calculator) { create(:calculator) }
  let(:update_calculator_button) { "Update calculator" }

  include_context :authorize_admin

  before do
    visit edit_account_calculator_path(slug: calculator.id)
  end

  # context "when user clicks button Update calculator" do
  #   it "shows message that calculator has been successfully updated" do
  #     fill_in "Name", with: "Calculator2"
  #     click_link_or_button update_calculator_button
  #     sleep 2
  #     expect(page).to have_content("Calculator has been successfully updated")
  #   end
  # end

  # context "when user fill in the Name field with name shorter than 2 symbols" do
  #   it "shows message that name is too short" do
  #     fill_in "Name", with: "o"
  #     click_link_or_button update_calculator_button
  #     expect(page).to have_content("Name is too short (minimum is 2 characters)")
  #   end
  # end

  # context "when user fill in the Name field with symbols" do
  #   it "shows message that name is invalid" do
  #     fill_in "Name", with: '\[d]]p'
  #     click_link_or_button update_calculator_button
  #     sleep 1
  #     expect(page).to have_content("Name contains invalid characters")
  #   end
  # end
end
