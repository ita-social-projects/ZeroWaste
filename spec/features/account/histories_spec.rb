# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  context "signed in admin visit page" do
    include_context :authorize_admin

    before do
      visit account_histories_path
    end

    #  FIX ME
    it "(page) contains some content" do
      expect(page).to have_content "Version creation date"
      expect(page).to have_content "Event ID"
      expect(page).to have_content "User ID"
      expect(page).to have_content "Action"
      expect(page).to have_content "More info: field, old value, new value"
      # expect(page).to have_content 'Model type'
    end
  end
end
