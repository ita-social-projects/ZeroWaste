# frozen_string_literal: true

require 'rails_helper'

describe 'visit Calculator page', js: true do
  it 'visits calculator page' do
    visit '/calculators/diaper-calculator'
    expect(page).to have_content 'receive email messages'
  end
end
