# frozen_string_literal: true

require "rails_helper"

BUDGETARY_OPTION = "budgetary"
MEDIUM_OPTION    = "medium"
PREMIUM_OPTION   = "premium"

describe "product category dropdown list", js: true do
  let(:calculator) { create(:calculator) }

  before do
    FeatureFlag.get("feature_budget_category").activate
    visit "/calculator"
    find(:select, "product_category")
    has_select?("product_category", with_options: [BUDGETARY_OPTION, MEDIUM_OPTION, PREMIUM_OPTION])
  end

  it "default product category" do
    expect(page).to have_select("product_category", selected: MEDIUM_OPTION)
  end

  it "custom product category selected" do
    select(BUDGETARY_OPTION, from: "product_category")
    expect(page).to have_select("product_category", selected: BUDGETARY_OPTION)
  end
end
