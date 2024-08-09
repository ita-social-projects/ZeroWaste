# frozen_string_literal: true

require "rails_helper"

xdescribe "User Sign Up", js: true do
  let(:email) { "Email" }
  let(:password) { "Password" }
  let(:re_password) { "Re-password" }
  let(:firstname) { "First name" }
  let(:lastname) { "Last name" }
  let(:sign_up_button_text) { I18n.t("layouts.navigation.sign_up") }

  context "when sign up with correct password and email" do
    it "shows a message about a confirmation link in the mail" do
      receive(:confirmation_instructions)
        .and_return(double(deliver: true))
      visit new_user_registration_path

      fill_in email, with: "simple@email.com"
      fill_in password, with: "111111111"
      fill_in re_password, with: "111111111"
      fill_in firstname, with: "User"
      fill_in lastname, with: "Users"
      select "Albania", from: "user_country"

      click_button sign_up_button_text

      expect(page).to have_content "A message with a confirmation link has "
    end
  end

  context "when sign up with incorrect password" do
    it "shows a message about incorrect password" do
      visit new_user_registration_path

      fill_in password, with: " "
      fill_in re_password, with: " "

      click_button sign_up_button_text

      expect(page).to have_content "Password can't be blank"
    end
  end

  context "when sign up with password is too short" do
    it "shows a message that password is too short" do
      visit new_user_registration_path

      fill_in password, with: "n"
      fill_in re_password, with: "n"

      click_button sign_up_button_text

      expect(page).to have_content "Password is too short"
    end
  end

  context "when sign up with incorrect email" do
    it "shows a message that Email is invalid" do
      visit new_user_registration_path

      fill_in email, with: " "

      click_button sign_up_button_text

      expect(page).to have_content "Email can't be blank"
    end
  end

  context "when sign up with incorrect first and last name" do
    it "shows a message that first and last name is invalid" do
      visit new_user_registration_path

      fill_in firstname, with: "123"
      fill_in lastname, with: " "

      click_button sign_up_button_text

      expect(page).to have_content "First name is invalid"
      expect(page).to have_content "Last name can't be blank"
    end
  end

  context "when sign up with short first and last name" do
    it "shows a message that first and last name is too short" do
      visit new_user_registration_path

      fill_in firstname, with: "A"
      fill_in lastname, with: "A"

      click_button sign_up_button_text

      expect(page).to have_content "First name is too short"
      expect(page).to have_content "Last name is too short"
      expect(page).to have_content "minimum is 2 characters"
    end
  end

  context "when sign up with blank first name" do
    it "shows only one error message that first name can't be blank" do
      visit new_user_registration_path

      fill_in firstname, with: " "

      click_button sign_up_button_text

      expect(page).to have_content "First name can't be blank"
      expect(page).not_to have_content "First name is too short"
      expect(page).not_to have_content "First name is invalid"
    end
  end
end
