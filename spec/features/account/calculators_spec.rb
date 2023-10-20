# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:diapers_calculator) { create(:calculator, name: "Diapers Calculator", slug: "diapers") }
  let!(:napkin_calculator) { create(:calculator, name: "Napkin Calculator", slug: "napkin") }

  include_context :authorize_admin

  it "visits admin page" do
    visit account_calculators_path

    expect(page).to have_content diapers_calculator.name
    expect(page).to have_content napkin_calculator.name
  end
end
