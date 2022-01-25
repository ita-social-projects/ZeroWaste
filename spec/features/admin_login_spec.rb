# frozen_string_literal: true

require 'rails_helper'

describe 'visit admin page', js: true do
  let(:admin) { create(:admin) }
  # TODO: Fix me
   context "when sign in with correct login and password" do
     it "redirect to admin page" do
       visit '/admins/sign_in'
       fill_in 'Email', with: admin.email
       fill_in 'Password', with: admin.password
       click_button 'Log in'
       expect(page).to have_content 'Dashboard'
     end
   end
  # context "when sign in with wrong login and password" do
  #   it "redirect to admin login page" do
  #     visit '/admins/sign_in'
  #     fill_in 'Email', with: 'wrong@email.com'
  #     fill_in 'Password', with: admin.password
  #     click_button 'Log in'
  #     expect(page).to have_content 'Log in'
  #   end
  # end
end
