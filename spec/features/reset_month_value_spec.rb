# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Year changed", request: true do
  it "Reset month value when year changes" do
    visit calculator_path

    year_select = find("#child_years")
    month_select = find("#child_months")

    year_select.select("0")
    expect(month_select.value).to eq ""

    year_select.select("1")
    expect(month_select.value).to eq ""

    year_select.select("2")
    expect(month_select.value).to eq ""
  end
end
