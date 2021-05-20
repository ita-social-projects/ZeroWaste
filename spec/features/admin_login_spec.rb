# frozen_string_literal: true

require 'rails_helper'

describe 'visit admin page', js: true do
  let(:admin) { create(:admin) }

  it "when sign in with correct login and password" do
    visit '/admins/sign_in' 
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
    expect(page).to have_content 'Dashboard'
  end
end
