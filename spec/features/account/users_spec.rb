# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let(:time_login) { Time.new(2020, 0o1, 0o1).in_time_zone("Kyiv") }
  let!(:another_user) do
    create(:user, email: "test1@gmail.com", password: "12345878",
                  last_sign_in_at: time_login)
  end
  let!(:admin_user) { create(:user, role: :admin) }

  include_context :authorize_admin

  it "visits admin page" do
    visit account_users_path
    expect(page).to have_content "test1@gmail.com"
    expect(page).to have_content time_login
  end

  context "when user clicks show icon" do
    it "redirects to user info page" do
      visit account_users_path
      within(:css, "#user-info-#{another_user.id}") do
        find(".fa-eye", visible: :all).click
        sleep 3
      end
      expect(page).to have_current_path(account_user_path(id: another_user.id))
      expect(page).to have_content "Email"
      expect(page).to have_content "First name"
      expect(page).to have_content "Last name"
      expect(page).to have_content "Country"
      expect(page).to have_content "Last signing in"
      expect(page).to have_content "Current IP-address"
      expect(page).to have_content "Last IP-address"
    end
  end

  context "when user clicks edit icon" do
    it "redirects to user edit info page" do
      visit account_users_path
      within(:css, "#user-info-#{another_user.id}") do
        find("a[href='#{edit_account_user_path(id: another_user.id)}']").click
        sleep 3
      end
      expect(page).to have_current_path(edit_account_user_path(id: another_user.id))
      expect(page).to have_content "First name"
      expect(page).to have_content "Last name"
      expect(page).to have_content "Country"
      expect(page).to have_content "Password"
      expect(page).to have_content "Re-password"
    end
  end

  context "when user clicks lock-open icon" do
    it "shows the correct confirmation message for blocking" do
      visit account_users_path

      within(:css, "#user-info-#{another_user.id}") do
        find("svg.fa-lock-open").click
        sleep 3
      end

      accept_confirm { "Are you sure you want to block this user?" }
      sleep 3
      expect(page).to have_current_path(account_user_path(id: another_user.id))
      expect(page).to have_content "Blocked"
    end
  end

  context "when user clicks lock icon" do
    it "shows the correct confirmation message for unblocking" do
      another_user.update(blocked: true)
      visit account_users_path

      within(:css, "#user-info-#{another_user.id}") do
        find("svg.fa-lock").click
        sleep 3
      end

      accept_confirm { "Are you sure you want to unblock this user?" }
      sleep 3
      expect(page).to have_current_path(account_user_path(id: another_user.id))
      expect(page).to have_content "Unblocked"
    end
  end

  context "when trying to block an admin user" do
    it "shows an alert message and redirects to account users path" do
      visit account_users_path

      within(:css, "#user-info-#{admin_user.id}") do
        expect(page).to have_no_css("svg.fa-lock-open") # Expect the lock-open button not to be present
      end
    end
  end

  context "when edit user`s info correctly" do
    it "redirects to user info page" do
      visit edit_account_user_path(id: another_user.id)
      find_by_id("user_first_name").set("John")
      find_by_id("user_last_name").set("Doe")
      select "Albania", from: "user_country"
      find_by_id("user_password").set("111111111")
      find_by_id("user_password_confirmation").set("111111111")
      find_button("commit").click
      sleep 1
      expect(page).to have_current_path(account_user_path(id: another_user.id))
      expect(page).to have_content "John"
      expect(page).to have_content "Doe"
      expect(page).to have_content "AL"
    end
  end

  context "when edit user`s info wrongly" do
    it "show error messages" do
      visit edit_account_user_path(id: another_user.id)
      find_by_id("user_first_name").set("J")
      find_by_id("user_last_name").set("D")
      select "Albania", from: "user_country"
      find_by_id("user_password").set("1")
      find_by_id("user_password_confirmation").set("2")
      find_button("commit").click
      sleep 2
      expect(page).to have_content "First name is too short (minimum is 2 characters)"
      expect(page).to have_content "Last name is too short (minimum is 2 characters)"
      expect(page).to have_content "Password is too short (minimum is 8 characters)"
      expect(page).to have_content "Re-password doesn't match Password"
    end
  end
end
