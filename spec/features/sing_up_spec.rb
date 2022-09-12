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
      select 'Benin', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'A message with a confirmation link has '
    end
  end

  context 'when sign up with incorrect password' do
    it 'to signUp' do
      visit '/users/sign_up'
      fill_in 'Email', with: 'user@gmail.com '
      fill_in 'Password', with: ' '
      fill_in 'Re-password', with: ' '
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      select 'Ukraine', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'Password is invalid'
    end
  end

  context 'when sign up with password is too short' do
    it 'redirect to signUp' do
      visit '/users/sign_up'
      fill_in 'Email', with: 'user1@gmail.com'
      fill_in 'Password', with: 'n'
      fill_in 'Re-password', with: 'n'
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      select 'Uganda', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'Password is invalid'
      expect(page).to have_content 'Password is too short'
    end
  end

  context 'when sign up with incorrect email' do
    it 'to sign up' do
      visit '/users/sign_up'
      fill_in 'Email', with: ' '
      fill_in 'Password', with: '1111111112'
      fill_in 'Re-password', with: '1111111112'
      fill_in 'First name', with: 'First'
      fill_in 'Last name', with: 'Last'
      select 'Aruba', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'Email is invalid'
    end
  end

  context 'when sign up with incorrect email' do
    it 'redirect to sign up page' do
      visit '/users/sign_up'
      fill_in 'Email', with: 'user@gmail.com'
      fill_in 'Password', with: '1111113111'
      fill_in 'Re-password', with: '1111113111'
      fill_in 'First name', with: '123'
      fill_in 'Last name', with: ' '
      select 'Andorra', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'First name is invalid'
      expect(page).to have_content 'minimum is 2 characters'
    end
  end
end


describe 'user views sign up', :type => :feature do
  context 'when the user has set their locale to :en' do
    let(:locale) { :en }

    it 'displays a translated welcome message to the user', :js => true do
      visit '/users/sign_up'
      expect(page).to have_content I18n.t('devise.registrations.new.sing_up_header')
    end
  end

  context 'when sign up with correct' do
    it 'to sign up page' do
    flash_message_disappear_time = 20
    visit '/users/sign_up'
    fill_in 'Email', with: 'users@gmail.com'
    fill_in 'Password', with: '1112111111'
    fill_in 'Re-password', with: '1112111111'
    fill_in 'First name', with: 'MyName'
    fill_in 'Last name', with: 'LastName'
    select 'Bahamas', from: 'user_country'
    click_button 'Sing Up'

    Capybara.using_wait_time flash_message_disappear_time do
      expect(page).to have_content ('A message with a confirmation link has been sent to your email address.')
    end
  end
  end
end
