# frozen_string_literal: true

require "rails_helper"

describe "visit Admin page", js: true do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  it "visits manage calculators page" do
    visit account_calculators_path

    expect(page).to have_content "You are not authorized to access this page."
  end

  it "visits manage histories page" do
    visit account_histories_path

    expect(page).to have_content "You are not authorized to access this page."
  end

  it "visits manage users page" do
    visit account_users_path

    expect(page).to have_content "You are not authorized to access this page."
  end

  it "visits messages page" do
    visit account_messages_path

    expect(page).to have_content "You are not authorized to access this page."
  end

  it "visits site settings page" do
    visit edit_account_site_setting_path

    expect(page).to have_content "You are not authorized to access this page."
  end
end
