# frozen_string_literal: true

require 'rails_helper'

describe 'visit admin page', js: true do
  context 'signed in admin visit page' do
    before (:each) do
      @admin=create(:admin)
      sign_in @admin
      visit "/admins/histories"
    end

    it '(page) contains some content' do
      expect(page).to have_content 'Version Created At'
      expect(page).to have_content 'Event Id:'
      expect(page).to have_content 'User Id:'
      expect(page).to have_content 'Action'
      expect(page).to have_content 'More Info (Field, Old Value, New Value)'
      expect(page).to have_content 'Model Type'
    end
  end
end
