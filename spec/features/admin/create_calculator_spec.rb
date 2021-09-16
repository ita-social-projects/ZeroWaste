# frozen_string_literal: true

require 'rails_helper'
CREATE_CALCULATOR_PATH = '/admins/calculators/new'

describe 'Create Calculator Page', js: true do
  let(:calculator) { create(:calculator) }

  context 'when user clicks button Create calculator' do
    it 'shows message that calculator has been successfully created' do
      visit CREATE_CALCULATOR_PATH
      fill_in 'Name', with: 'Calculator1'
      click_button 'Create calculator'
      expect(page).to have_content('Calculator has been successfully created')
    end
  end

  context 'when user clicks button Create calculator' do
    it 'redirects to Edit calculator page' do
      visit CREATE_CALCULATOR_PATH
      fill_in 'Name', with: 'Calculator2'
      click_button 'Create calculator'
      expect(page).to have_current_path("/admins/calculators/1/edit")
    end
  end

  context 'when user fill in the Name field with name that already exist' do
    it 'shows message that name is already has been taken' do
      visit CREATE_CALCULATOR_PATH
      fill_in 'Name', with: calculator.name
      click_button 'Create calculator'
      expect(page).to have_content('Name has already been taken')
    end
  end

  context 'when user fill in the Name field with name shorter than 2 symbols' do
    it 'shows message that name is too short' do
      visit CREATE_CALCULATOR_PATH
      fill_in 'Name', with: 'i'
      click_button 'Create calculator'
      expect(page).to have_content("The field 'Name' is too short.")
    end
  end

  context 'when user fill in the Name field with symbols' do
    it 'shows message that name is invalid' do
      visit CREATE_CALCULATOR_PATH
      fill_in 'Name', with: 'i[]p'
      click_button 'Create calculator'
      expect(page).to have_content("The field 'Name' is invalid")
    end
  end

  context 'when user left the Name field blank' do
    it 'shows message that name can\'t be blank' do
      visit CREATE_CALCULATOR_PATH
      fill_in 'Name', with: ''
      click_button 'Create calculator'
      expect(page).to have_content("The field 'Name' can\'t be blank.")
    end
  end
end
