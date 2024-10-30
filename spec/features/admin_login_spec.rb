# frozen_string_literal: true

require "rails_helper"

RSpec.feature "AdminLogins", type: :feature do
  describe "sign in admin page", js: true do
    let(:lang_button_text) { I18n.t("layouts.navigation.local_lang") }
    let(:user) { create(:user, :admin) }

    before { visit new_user_session_path }

    context "english local" do
      context "when sign in with correct login and password" do
        it "redirect to admin page" do
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          sleep 0.5
          click_link_or_button "Log In"
          sleep 0.5
          expect(page).to have_content "Signed in successfully"
        end
      end

      context "when sign in with wrong login and password" do
        it "redirect to admin login page" do
          fill_in "Email", with: "wrong@email.com"
          fill_in "Password", with: "wrong password"
          sleep 0.5
          click_link_or_button "Log In"
          sleep 0.5
          expect(page).to have_content "Invalid Email or password"
        end
      end

      context "when sign in with wrong password" do
        it "redirect to admin login page" do
          fill_in "Email", with: user.email
          fill_in "Password", with: "wrong password"
          sleep 0.5
          click_link_or_button "Log In"
          sleep 0.5
          expect(page).to have_content "Invalid Email or password"
        end
      end

      context "when sign in with wrong login" do
        it "redirect to admin login page" do
          fill_in "Email", with: "wrong@email.com"
          fill_in "Password", with: user.password
          sleep 0.5
          click_link_or_button "Log In"
          sleep 0.5
          expect(page).to have_content "Invalid Email or password"
        end
      end
    end

    context "with ukrainian locale" do
      context "when sign in with correct login and password" do
        xit "redirect to admin page" do
          click_link_or_button lang_button_text
          fill_in "user_email", with: user.email
          fill_in "user_password", with: user.password
          sleep 0.5
          click_link_or_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Ви увійшли до системи"
        end
      end

      context "when sign in with wrong login and password" do
        xit "redirect to admin login page" do
          click_link_or_button lang_button_text
          fill_in "user_email", with: "wrong@email.com"
          fill_in "user_password", with: "wrong password"
          sleep 0.5
          click_link_or_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Невірна електронна пошта чи пароль"
        end
      end

      context "when sign in with wrong password" do
        xit "redirect to admin login page" do
          click_link_or_button lang_button_text
          fill_in "user_email", with: user.email
          fill_in "user_password", with: "wrong password"
          sleep 0.5
          click_link_or_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Невірна електронна пошта чи пароль"
        end
      end

      context "when sign in with wrong login" do
        xit "redirect to admin login page" do
          click_link_or_button lang_button_text
          fill_in "user_email", with: "wrong@email.com"
          fill_in "user_password", with: user.password
          sleep 0.5
          click_link_or_button "Увійти"
          sleep 0.5
          expect(page).to have_content "Невірна електронна пошта чи пароль"
        end
      end
    end
  end
end
