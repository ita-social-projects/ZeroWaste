# frozen_string_literal: true

require 'rails_helper'

describe 'sign out', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }
  before do
    allow_any_instance_of(ApplicationController).to receive(:after_sign_in_path_for).and_return("/calculators/#{calculator.slug}")
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    click_link 'Log Out'
  end

  it "signs the user out" do
    expect(page).to have_current_path("/calculators/#{calculator.slug}")
    expect(page).to have_selector("a[href='/users/sign_in']")
  end
end
