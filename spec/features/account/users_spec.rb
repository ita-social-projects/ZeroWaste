# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let(:time_login) { Time.new(2020, 0o1, 0o1).utc }
  let!(:another_user) do
    create(:user, email: "test1@gmail.com", password: "12345878",
                  last_sign_in_at: time_login)
  end

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
        click_link(href: edit_account_user_path(id: another_user.id))
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

  context "when edit user`s info correctly" do
    it "redirects to user info page" do
      visit edit_account_user_path(id: another_user.id)
      find("#user_first_name").set("John")
      find("#user_last_name").set("Doe")
      select "Albania", from: "user_country"
      find("#user_password").set("111111111")
      find("#user_password_confirmation").set("111111111")
      find_button("commit").click
      expect(page).to have_current_path(account_user_path(id: another_user.id))
      expect(page).to have_content "John"
      expect(page).to have_content "Doe"
      expect(page).to have_content "AL"
    end
  end

  context "when edit user`s info wrongly" do
    it "show error messages" do
      visit edit_account_user_path(id: another_user.id)
      find("#user_first_name").set("J")
      find("#user_last_name").set("D")
      select "Albania", from: "user_country"
      find("#user_password").set("1")
      find("#user_password_confirmation").set("2")
      find_button("commit").click
      expect(page).to have_content "First name is too short (minimum is 2 characters)"
      expect(page).to have_content "Last name is too short (minimum is 2 characters)"
      expect(page).to have_content "Password is too short (minimum is 8 characters)"
      expect(page).to have_content "Re-password doesn't match Password"
    end
  end

  describe "user info page" do
    context "viewing non-existing user" do
      it "renders the 404 page" do
        visit account_user_path(id: 1355)
        expect(page).to have_content("page you were looking for doesn't exist")
      end
    end
  end
end
