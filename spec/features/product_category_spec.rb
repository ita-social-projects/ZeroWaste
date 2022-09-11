# frozen_string_literal: true

require 'rails_helper'

BUDGETARY = 'budgetary'.freeze
MEDIUM = 'medium'.freeze
PREMIUM = 'premium'.freeze

describe 'product category dropdown list', js: true do
  let(:calculator) { create(:calculator) }
  before do
    FeatureFlag.get('feature_budget_category').activate
    visit '/calculator'
    find(:select, 'product_category')
    has_select?('product_category', with_options: [BUDGETARY, MEDIUM, PREMIUM])
  end

  it 'default product category' do
    expect(page).to have_select('product_category', selected: 'medium')
  end

  it 'custom product category selected' do
    select('budgetary', from: 'product_category')
    expect(page).to have_select('product_category', selected: 'budgetary')
  end
end
