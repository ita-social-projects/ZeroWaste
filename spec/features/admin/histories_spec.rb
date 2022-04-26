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
      expect(page).to have_content 'Version creation date'
      expect(page).to have_content 'Event ID'
      expect(page).to have_content 'User ID'
      expect(page).to have_content 'Action'
      expect(page).to have_content 'More info: field, old value, new value'
      expect(page).to have_content 'Model type'
    end
  end
end
