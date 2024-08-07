# frozen_string_literal: true

require "rails_helper"

xdescribe "Password Reset Page", js: true do
  let(:password_reset_path) { new_user_password_path }
  let(:user) { create(:user) }

  context "when user clicks button Send me reset password instructions" do
    it "shows message that user will receive reset password instructions" do
      receive(:reset_password_instructions)
        .and_return(double(deliver: true))
      visit password_reset_path
      fill_in "user_email", with: user.email
      click_link_or_button "Reset"
      expect(page).to have_content("If your email address exists")
    end
  end

  context "when user clicks Log in link" do
    it "redirect to sign in page" do
      visit password_reset_path
      click_on "Log In"
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
