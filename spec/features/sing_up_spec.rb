# frozen_string_literal: true

require 'rails_helper'

EMAIL = 'Email'
PASSWORD = 'Password'
RE_PASSWORD = 'Re-password'
FIRSTNAME = 'First name'
LASTNAME = 'Last name'
SIGN_UP_BUTTON_TEXT = I18n.t('layouts.navigation.sign_up')


describe 'User Sign Up', js: true do
  context 'when sign up with correct password and email' do
    it 'shows a message about a confirmation link in the mail' do
      receive(:confirmation_instructions)
        .and_return(double(deliver: true))
      visit new_user_registration_path

      fill_in EMAIL, with: 'simple@email.com'
      fill_in PASSWORD, with: '111111111'
      fill_in RE_PASSWORD, with: '111111111'
      fill_in FIRSTNAME, with: 'User'
      fill_in LASTNAME, with: 'Users'
      select 'Albania', from: 'user_country'

      click_button SIGN_UP_BUTTON_TEXT

      expect(page).to have_content 'A message with a confirmation link has '
    end
  end

  context 'when sign up with incorrect password' do
    it 'shows a message about incorrect password' do
      visit new_user_registration_path

      fill_in PASSWORD, with: ' '
      fill_in RE_PASSWORD, with: ' '

      click_button SIGN_UP_BUTTON_TEXT

      expect(page).to have_content 'Password is invalid'
    end
  end

  context 'when sign up with password is too short' do
    it 'shows a message that password is too short' do
      visit new_user_registration_path

      fill_in PASSWORD, with: 'n'
      fill_in RE_PASSWORD, with: 'n'

      click_button SIGN_UP_BUTTON_TEXT

      expect(page).to have_content 'Password is too short'
    end
  end

  context 'when sign up with incorrect email' do
    it 'shows a message that Email is invalid' do
      visit new_user_registration_path

      fill_in EMAIL, with: ' '

      click_button SIGN_UP_BUTTON_TEXT

      expect(page).to have_content 'Email is invalid'
    end
  end

  context 'when sign up with incorrect first and last name' do
    it 'shows a message that first and last name is invalid' do
      visit new_user_registration_path

      fill_in FIRSTNAME, with: '123'
      fill_in LASTNAME, with: ' '

      click_button SIGN_UP_BUTTON_TEXT

      expect(page).to have_content 'First name is invalid'
      expect(page).to have_content 'Last name can\'t be blank'
      expect(page).to have_content 'Last name is too short'
      expect(page).to have_content 'minimum is 2 characters'
    end
  end
end
