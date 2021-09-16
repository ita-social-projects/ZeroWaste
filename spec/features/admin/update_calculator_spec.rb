# frozen_string_literal: true

require 'rails_helper'

describe 'Update Calculator Page', js: true do
  let(:calculator) { create(:calculator) }
  
  context 'when user clicks button Update calculator' do
    it 'shows message that calculator has been successfully updated' do
      visit "/admins/calculators/#{calculator.id}/edit"
      fill_in 'Name', with: 'Calculator2'
      click_button 'Update calculator'
      expect(page).to have_content('Calculator has been successfully updated')
    end
  end

  context 'when user fill in the Name field with name shorter than 2 symbols' do
    it 'shows message that name is too short' do
      visit "/admins/calculators/#{calculator.id}/edit"
      fill_in 'Name', with: 'o'
      click_button 'Update calculator'
      expect(page).to have_content("The field 'Name' is too short.")
    end
  end

  context 'when user fill in the Name field with symbols' do
    it 'shows message that name is invalid' do
      visit "/admins/calculators/#{calculator.id}/edit"
      fill_in 'Name', with: '\[d]]p'
      click_button 'Update calculator'
      expect(page).to have_content("The field 'Name' is invalid")
    end
  end

  context 'when user left the Name field blank' do
    it 'shows message that name can\'t be blank' do
      visit "/admins/calculators/#{calculator.id}/edit"
      fill_in 'Name', with: ''
      click_button 'Update calculator'
      expect(page).to have_content("The field 'Name' can\'t be blank.")
    end
  end
end
