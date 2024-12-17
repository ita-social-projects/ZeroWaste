# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Year changed", type: :feature do
  let(:year_select) { find_by_id("child_years") }
  let(:month_select) { find_by_id("child_months") }

  it "resets month value when year changes" do
    visit calculator_path

    year_select.select("0")
    expect(month_select.value).to eq("")

    year_select.select("1")
    expect(month_select.value).to eq("")

    year_select.select("2")
    expect(month_select.value).to eq("")
  end
end
