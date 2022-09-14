# frozen_string_literal: true

require 'rails_helper'
def fill_field_sign_up (email, password, re_password, first_name, last_name)
  visit '/users/sign_up'
  @email = email
  @password = password
  @re_password = re_password
  @first_name = first_name
  @last_name = last_name
  fill_in 'Email', with: @email
  fill_in 'Password', with: @password
  fill_in 'Re-password', with: @re_password
  fill_in 'First name', with: @first_name
  fill_in 'Last name', with: @last_name
  select 'Bahamas', from: 'user_country'
  click_button 'Sing Up'
end

describe 'User Sign Up', js: true do
  context 'when sign up with correct password and email' do
    it 'shows a message about a confirmation link in the mail' do
      receive(:confirmation_instructions)
        .and_return(double(deliver: true))
      fill_field_sign_up 'users@gmail.com', 'password1', 'password1', 'Margaret', 'Thatcher'
      expect(page).to have_content 'A message with a confirmation link has '
    end
  end

  context 'when sign up with incorrect password' do
    it 'to signUp' do
      fill_field_sign_up 'users@gmail.com', ' ', ' ', 'Margaret', 'Thatcher'
      expect(page).to have_content 'Password is invalid'
    end
  end

  context 'when sign up with password is too short' do
    it 'redirect to signUp' do
      fill_field_sign_up 'users@gmail.com', 'n', 'n', 'Margaret', 'Thatcher'
      expect(page).to have_content 'Password is too short'
    end
  end

  context 'when sign up with incorrect email' do
    it 'to sign up' do
      visit '/users/sign_up'
      fill_field_sign_up ' ', 'Password1', 'Password1', 'Margaret', 'Thatcher'
      expect(page).to have_content 'Email is invalid'
    end
  end

  context 'when sign up with incorrect email' do
    it 'redirect to sign up page' do
      fill_field_sign_up 'users@gmail.com', 'Password1', 'Password1', '123', ' '
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
    fill_field_sign_up 'users@gmail.com', 'Password1', 'Password1', 'Margaret', 'Thatcher'
    Capybara.using_wait_time flash_message_disappear_time do
      expect(page).to have_content ('A message with a confirmation link has been sent to your email address.')
    end
  end
  end
end
