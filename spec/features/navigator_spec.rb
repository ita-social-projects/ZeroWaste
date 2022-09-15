# frozen_string_literal: true

require 'rails_helper'

describe 'navigator', js: true do
  it 'should style the navbar' do
    visit root_path
    expect(page).to have_css('.page-header')
    expect(page.body).to have_css('.tabs')
  end

  context 'when feature show_admin_menu does not exist' do
    it 'should not consist tabs' do
      visit root_path
      expect(page).not_to have_content("SIGN UP")
      expect(page).not_to have_content("LOG IN")
      expect(page).not_to have_content("CONTACT US")
    end
  end

  context 'when feature show_admin_menu is disabled' do
    it 'should not consist tabs' do
      create(:feature_flag, :hide_admin_menu)
      visit root_path
      expect(page).not_to have_content("SIGN UP")
      expect(page).not_to have_content("LOG IN")
      expect(page).not_to have_content("CONTACT US")
    end
  end
  
  context 'when feature show_admin_menu is enabled' do
    it 'should consist tabs' do
      create(:feature_flag, :show_admin_menu)
      visit root_path
      expect(page).to have_content("SIGN UP")
      expect(page).to have_content("LOG IN")
      expect(page).to have_content("CONTACT US")
    end
  end
end
