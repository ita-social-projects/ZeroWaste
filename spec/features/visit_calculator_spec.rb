# frozen_string_literal: true

require 'rails_helper'

describe 'visit Calculator page', js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }

  it 'visits calculator page' do
    visit "/calculators/#{calculator.slug}"
    expect(page).to have_content
                         I18n.t('.calculators.calculator.desire_getting_email')
  end


  xit "visits calculator page and open log_in page" do
    visit "/calculators/#{calculator.slug}"
    click_link ('Log In')
    expect(page).to have_content 'Forgot your password'
  end
end
