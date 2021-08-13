#Add Capybara test for Sign Up page
#ZER-46
require 'rails_helper'

describe "User Sign Up",  js: true do
  #let(:new_user) { create(:new_user) }
  let(:calculator) { create(:calculator) }
    it "Right registers a new user" do
      allow_any_instance_of(ApplicationController).to receive(:after_sign_in_path_for).and_return("/calculators/#{calculator.slug}")
      allow(Devise::Mailer).to receive(:confirmation_instructions).and_return(double(deliver: true))
      visit '/users/sign_up'

      # click_link "Sign Up"
      fill_in 'Email', with: 'simple@email.com'
      fill_in 'Password', with: '111111111'
      fill_in 'Password Confirmation', with: '111111111'
      fill_in 'First Name', with: 'User'
      fill_in 'Last Name', with: 'Users'
      select 'Albania', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'Yay! You’re on Rails!'
      #expect(page).to have_current_path "/users"
      #expect(page).to have_selector("a[href='/users']")
    end

    it "Wrong registers a new user" do
      visit '/users/sign_up'

      # click_link "Sign Up"
      fill_in 'Email', with: 'wrong email.com'
      fill_in 'Password', with: '1'
      fill_in 'Password Confirmation', with: '11'
      fill_in 'First Name', with: ' '
      fill_in 'Last Name', with: ' '
      select 'Albania', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_text 'Password (6 Characters Minimum)'# different between have_text and have_content
    end

    it "No right password" do
      visit '/users/sign_up'

      fill_in 'Email', with: 'simple@email.com'
      fill_in 'Password', with: ' '
      fill_in 'Password Confirmation', with: '1111111'
      fill_in 'First Name', with: 'User'
      fill_in 'Last Name', with: 'User'
      select 'Albania', from: 'user_country'
      click_button 'Sing Up'
      expect(page).to have_content 'Email'
    end
end

