# frozen_string_literal: true

require 'rails_helper'

describe 'visit admin page', js: true do
  context 'when visit admins histories path' do
    it 'has content' do
      visit '/admins/histories'
      expect(page).to have_content 'Version Created At'
      expect(page).to have_content 'Event Id:'
      expect(page).to have_content 'User Id:'
      expect(page).to have_content 'Action'
      expect(page).to have_content 'More Info (Field, Old Value, New Value)'
      expect(page).to have_content 'Author'
    end
  end
end
