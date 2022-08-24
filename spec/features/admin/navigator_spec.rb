require 'rails_helper'

  RSpec.feature 'Сontacts css', type: :feature do
    describe 'contacts css on entry page', js: true do
      context 'when entry page' do
        before do
          visit root_path
        end
        it 'css' do
          expect(page).to have_css('.page-header')
          expect(page).to have_css('.tabs')
        end
      end
    end
  end

  RSpec.feature 'Сontacts', type: :feature do
    describe 'contacts on entry page to link', js: true do
      context 'when redirect to link' do
        before do
          visit root_path
        end
        it 'when redirect to link' do
          expect(page).to have_link('contacts')
          click_link('contacts', href: 'https://zerowastelviv.org.ua/en/contacts/')
        end
      end
    end
  end