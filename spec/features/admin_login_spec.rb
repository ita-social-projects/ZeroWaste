# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'AdminLogins', type: :feature do
  describe 'sign in admin page', js: true do
    subject { create(:user, :admin) }
    context 'when sign in with correct login and password' do
      it 'redirect to admin page' do
        visit '/users/sign_in'
        fill_in 'Email', with: subject.email
        fill_in 'Password', with: subject.password
        click_button 'Log in'
        expect(page).to have_content 'Signed in successfully.'
      end
    end
    context 'when sign in with wrong login and password' do
      it 'redirect to admin login page' do
        visit '/users/sign_in'
        fill_in 'Email', with: 'wrong@email.com'
        fill_in 'Password', with: 'wrong password'
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password'
      end
    end
    context 'when sign in with wrong password' do
      it 'redirect to admin login page' do
        visit '/users/sign_in'
        fill_in 'Email', with: subject.email
        fill_in 'Password', with: 'wrong password'
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password'
      end
    end
    context 'when sign in with wrong login' do 
      it 'redirect to admin login page' do
        visit '/users/sign_in'
        fill_in 'Email', with: 'wrong@email.com'
        fill_in 'Password', with: subject.password
        click_button 'Log in'
        expect(page).to have_content 'Invalid Email or password'
      end
    end
  end
end
