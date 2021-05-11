# frozen_string_literal: true

require 'rails_helper'

describe 'visit Calculator page', js: true do
  let(:user) { create(:user) }
  before { create(:calculator) }

  it 'visits calculator page' do
    visit '/calculators/diapers-calculator'
    expect(page).to have_content 'receive email messages'
  end

  it "visits calculator page and open log_in page" do
    visit '/calculators/diapers-calculator' 
    find('#log_in').click
    expect(page).to have_content 'Log in'
  end

  it "when sign in with correct login and password" do
    allow_any_instance_of(ApplicationController).to receive(:after_sign_in_path_for).and_return('/calculators/diapers-calculator')
    visit '/users/sign_in' 
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_selector("a[href='/users/sign_out']")
  end
end
