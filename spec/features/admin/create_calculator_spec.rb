# frozen_string_literal: true

require 'rails_helper'
CREATE_CALCULATOR_BUTTON = 'Create calculator'

describe 'Create Calculator Page', js: true do
  let!(:admin){ create(:admin) }
  let(:calculator) { create(:calculator) }
  before do
    visit '/admins/calculators/new'
  end

  context 'when user clicks button Create calculator' do
    it 'shows message that calculator has been successfully created' do
      fill_in 'Name', with: 'Calculator1'
      click_button CREATE_CALCULATOR_BUTTON
      expect(page).to have_content('Calculator has been successfully created')
    end
  end

  context 'when user clicks button Create calculator' do
    it 'redirects to Index calculator page' do
      fill_in 'Name', with: 'Calculator2'
      click_button CREATE_CALCULATOR_BUTTON
      expect(page).to have_current_path(admins_calculators_path)
    end
  end

  context 'when user fill in the Name field with name that already exist' do
    it 'shows message that name is already has been taken' do
      fill_in 'Name', with: calculator.name
      click_button CREATE_CALCULATOR_BUTTON
      expect(page).to have_content('Name has already been taken')
    end
  end

  context 'when user fill in the Name field with name shorter than 2 symbols' do
    it 'shows message that name is too short' do
      fill_in 'Name', with: 'i'
      click_button CREATE_CALCULATOR_BUTTON
      expect(page).to have_content("is too short")
    end
  end

  context 'when user fill in the Name field with symbols' do
    it 'shows message that name is invalid' do
      fill_in 'Name', with: 'i[]p'
      click_button CREATE_CALCULATOR_BUTTON
      expect(page).to have_content("is invalid")
    end
  end

  context 'when user left the Name field blank' do
    it 'shows message that name can\'t be blank' do
      fill_in 'Name', with: ''
      click_button CREATE_CALCULATOR_BUTTON
      expect(page).to have_content("is too short")
    end
  end
end
