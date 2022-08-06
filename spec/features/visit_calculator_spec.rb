# frozen_string_literal: true

require 'rails_helper'
if Rails.env.development?
describe 'visit Calculator page', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }

  describe 'visit Calculator page for ENV' do
    context 'ascending mode' do
      before do
        ENV['production'] = 'receive email messages'
      end
  it 'visits calculator page' do
    visit "/calculators/#{calculator.slug}"
    expect(page).to have_content 'receive email messages'
  end
    end
    context 'descending mode' do
      before do
        ENV['production'] = 'Forgot your password'
      end
  it "visits calculator page and open log_in page" do
    visit "/calculators/#{calculator.slug}"
    click_link ('Log In')
    expect(page).to have_content 'Forgot your password'
  end
end
  end
end
end