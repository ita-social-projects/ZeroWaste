require 'rails_helper'

  RSpec.feature 'Link Contacts', type: :feature do
    describe 'contacts on entry page', js: true do
      context 'when follow the link' do
        before do
          visit root_path
        end

        it 'is not valid without a css style' do
          expect(page).to have_css('.page-header')
          expect(page).to have_css('.tabs')
        end

        it 'is not valid without a link' do
          expect(page).to have_link('contacts')
          click_link('contacts', href: 'https://zerowastelviv.org.ua/en/contacts/')
      end
    end
    end
  end
