# frozen_string_literal: true

require "rails_helper"

LANG_BUTTON_TEXT = I18n.t("layouts.navigation.local_lang")

RSpec.feature "AdminLogins", type: :feature do
  describe "sign in admin page", js: true do
    let(:user) { create(:user, :admin) }

    context "english local" do
      context "when sign in with correct login and password" do
        it "redirect to admin page" do
          visit "/users/sign_in"
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          sleep 0.5
          click_button "Log in"
          sleep 0.5
          expect(page).to have_content "Signed in successfully."
        end
      end

      context "when sign in with wrong login and password" do
        it "redirect to admin login page" do
          visit "/users/sign_in"
          fill_in "Email", with: "wrong@email.com"
          fill_in "Password", with: "wrong password"
          sleep 0.5
          click_button "Log in"
          sleep 0.5
          expect(page).to have_content "Invalid Email or password"
        end
      end

      context "when sign in with wrong password" do
        it "redirect to admin login page" do
          visit "/users/sign_in"
          fill_in "Email", with: user.email
          fill_in "Password", with: "wrong password"
          sleep 0.5
          click_button "Log in"
          sleep 0.5
          expect(page).to have_content "Invalid Email or password"
        end
      end

      context "when sign in with wrong login" do
        it "redirect to admin login page" do
          visit "/users/sign_in"
          fill_in "Email", with: "wrong@email.com"
          fill_in "Password", with: user.password
          sleep 0.5
          click_button "Log in"
          sleep 0.5
          expect(page).to have_content "Invalid Email or password"
        end
      end
    end

    context "with ukrainian locale" do
      context "when sign in with correct login and password" do
        it "redirect to admin page" do
          visit new_user_session_path
          click_on LANG_BUTTON_TEXT
          fill_in "user_email", with: user.email
          fill_in "user_password", with: user.password
          sleep 0.5
          click_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Ви увійшли до системи."
        end
      end

      context "when sign in with wrong login and password" do
        it "redirect to admin login page" do
          visit new_user_session_path
          click_on LANG_BUTTON_TEXT
          fill_in "user_email", with: "wrong@email.com"
          fill_in "user_password", with: "wrong password"
          sleep 0.5
          click_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Невірний email чи пароль."
        end
      end

      context "when sign in with wrong password" do
        it "redirect to admin login page" do
          visit new_user_session_path
          click_on LANG_BUTTON_TEXT
          fill_in "user_email", with: user.email
          fill_in "user_password", with: "wrong password"
          sleep 0.5
          click_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Невірний email чи пароль."
        end
      end

      context "when sign in with wrong login" do
        it "redirect to admin login page" do
          visit new_user_session_path
          click_on LANG_BUTTON_TEXT
          fill_in "user_email", with: "wrong@email.com"
          fill_in "user_password", with: user.password
          sleep 0.5
          click_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Невірний email чи пароль."
        end
      end
    end
  end
end
