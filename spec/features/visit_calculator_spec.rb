# frozen_string_literal: true

require 'rails_helper'

describe 'visit Calculator page', js: true do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }
  
  it 'visits calculator page ENG localization' do
    visit "/calculators/#{calculator.slug}"
    expect(page).to have_content 'Yes, I want to receive email messages'
  end

  it 'visits calculator page UKR localization' do
    visit "/calculators/#{calculator.slug}"
    expect(page).to have_content(
                      'Так, Я бажаю отримувати повідомлення електронною поштою')
  end

  xit "visits calculator page and open log_in page" do
    visit "/calculators/#{calculator.slug}"
    click_link ('Log In')
    expect(page).to have_content 'Forgot your password'
  end
end
