# frozen_string_literal: true

require 'rails_helper'

describe 'User Sign Up', js: true do
  context 'when sign up with correct password and email' do
    it 'shows a message about a confirmation link in the mail' do
      receive(:confirmation_instructions)
        .and_return(double(deliver: true))
      visit new_user_registration_path

      fill_in 'Email', with: 'simple@email.com'
      fill_in 'Password', with: '111111111'
      fill_in 'Re-password', with: '111111111'
      fill_in 'First name', with: 'User'
      fill_in 'Last name', with: 'Users'
      select 'Albania', from: 'user_country'

      click_button 'Sign Up'

      expect(page).to have_content 'A message with a confirmation link has '
    end
  end

  context 'when sign up with incorrect password' do
    it 'shows a message about incorrect password' do
      visit new_user_registration_path

      fill_in 'Email', with: 'users@gmail.com'
      fill_in 'Password', with: ' '
      fill_in 'Re-password', with: ' '
      fill_in 'First name', with: 'Margaret'
      fill_in 'Last name', with: 'Thatcher'
      select 'Albania', from: 'user_country'

      click_button 'Sign Up'

      expect(page).to have_content 'Password is invalid'
    end
  end

  context 'when sign up with password is too short' do
    it 'shows a message that password is too short' do
      visit new_user_registration_path

      fill_in 'Email', with: 'users@gmail.com'
      fill_in 'Password', with: 'n'
      fill_in 'Re-password', with: 'n'
      fill_in 'First name', with: 'Margaret'
      fill_in 'Last name', with: 'Thatcher'
      select 'Albania', from: 'user_country'

      click_button 'Sign Up'

      expect(page).to have_content 'Password is too short'
    end
  end

  context 'when sign up with incorrect email' do
    it 'shows a message that Email is invalid' do
      visit new_user_registration_path

      fill_in 'Email', with: ' '
      fill_in 'Password', with: 'Password1'
      fill_in 'Re-password', with: 'Password1'
      fill_in 'First name', with: 'Margaret'
      fill_in 'Last name', with: 'Thatcher'
      select 'Albania', from: 'user_country'

      click_button 'Sign Up'

      expect(page).to have_content 'Email is invalid'
    end
  end

  context 'when sign up with incorrect first and last name' do
    it 'shows a message that first and last name is invalid' do
      visit new_user_registration_path

      fill_in 'Email', with: 'users@gmail.com'
      fill_in 'Password', with: 'Password1'
      fill_in 'Re-password', with: 'Password1'
      fill_in 'First name', with: '123'
      fill_in 'Last name', with: ' '
      select 'Albania', from: 'user_country'

      click_button 'Sign Up'

      expect(page).to have_content 'First name is invalid'
      expect(page).to have_content 'minimum is 2 characters'
    end
  end

  # context 'when the user has set their locale to :uk' do
  #   it 'displays a translated welcome message to the user' do
  #     visit new_user_registration_path(locale: :uk)

  #     expect(new_user_registration_path).to eq('/uk')
  #     expect(page).to have_content ('Зареєструватися')
  #   end
  # end
end
