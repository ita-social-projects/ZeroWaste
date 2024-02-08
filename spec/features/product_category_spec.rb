# frozen_string_literal: true

require "rails_helper"

describe "product category dropdown list in new design", js: true do
  let(:calculator) { create(:calculator) }
  let!(:budgetary_category) { create(:category, :budgetary) }
  let!(:preferable_category) { create(:category, :preferable) }

  include_context :new_calculator_design

  before do
    visit "/calculator"

    find(:select, "child_product_category")
    has_select?("child_product_category", with_options: ["budgetary", "medium", "premium"])
  end

  it "default product category" do
    expect(page).to have_select("child_product_category", selected: "preferable")
  end

  it "custom product category selected" do
    select("budgetary", from: "child_product_category")
    expect(page).to have_select("child_product_category", selected: "budgetary")
  end
end
