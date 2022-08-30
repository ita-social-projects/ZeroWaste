# frozen_string_literal: true

require 'rails_helper'

describe 'User Sign Up', js: true do
  context 'when sign up with correct password and email' do
    it 'shows a message about a confirmation link in the mail' do
      receive(:confirmation_instructions)
        .and_return(double(deliver: true))
      visit '/users/sign_up'
      fill_in 'Email', with: 'simple@email.com'
      fill_in 'Password', with: '111111111'
      fill_in 'Re-password', with: '111111111'
      fill_in 'First name', with: 'User'
      fill_in 'Last name', with: 'Users'
      select 'Albania', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'A message with a confirmation link has '
    end
  end

  # TODO: Fix me
  # context 'when sign up with incorrect password or email' do
  #   it 'redirect to sign up page' do
  #     visit '/users/sign_up'
  #     fill_in 'Email', with: ' '
  #     fill_in 'Password', with: ' '
  #     fill_in 'Password Confirmation', with: ' '
  #     fill_in 'First Name', with: ' '
  #     fill_in 'Last Name', with: ' '
  #     select 'Albania', from: 'user_country'
  #     click_button 'Sing Up'
  #     expect(page).to have_content 'Password (6 Characters Minimum)'
  #   end
  # end
end
