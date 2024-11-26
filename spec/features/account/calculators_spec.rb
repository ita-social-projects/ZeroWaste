# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:diapers_calculator) { create(:calculator, en_name: "Diapers Calculator") }
  let!(:napkin_calculator) { create(:calculator, en_name: "Napkin Calculator") }

  include_context :authorize_admin
  include_context :show_constructor

  it "visits admin page" do
    visit account_calculators_path

    expect(page).to have_content diapers_calculator.name
    expect(page).to have_content napkin_calculator.name
  end
end
