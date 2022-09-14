# frozen_string_literal: true

require 'rails_helper'

describe 'visit Login page', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }

  xit 'when sign in with correct login and password' do
    allow_any_instance_of(ApplicationController)
      .to receive(:after_sign_in_path_for)
      .and_return("/calculators/#{calculator.slug}")
    allow(Devise::Mailer).to receive(:confirmation_instructions)
      .and_return(double(deliver: true))
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_selector("a[href='/users/sign_out']")
  end
end
