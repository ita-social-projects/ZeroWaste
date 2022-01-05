# frozen_string_literal: true

require 'rails_helper'
UPDATE_CALCULATOR_BUTTON = 'Update calculator'

describe 'Update Calculator Page', js: true do
  let(:calculator) { create(:calculator) }
  before do 
    visit "/admins/calculators/#{calculator.id}/edit"
  end

  context 'when user clicks button Update calculator' do
    it 'shows message that calculator has been successfully updated' do
      fill_in 'Name', with: 'Calculator2'
      click_button UPDATE_CALCULATOR_BUTTON
      expect(page).to have_content('Calculator has been successfully updated')
    end
  end

  context 'when user fill in the Name field with name shorter than 2 symbols' do
    it 'shows message that name is too short' do
      fill_in 'Name', with: 'o'
      click_button UPDATE_CALCULATOR_BUTTON
      expect(page).to have_content("is too short")
    end
  end

  context 'when user fill in the Name field with symbols' do
    it 'shows message that name is invalid' do
      fill_in 'Name', with: '\[d]]p'
      click_button UPDATE_CALCULATOR_BUTTON
      expect(page).to have_content("is invalid")
    end
  end
end
