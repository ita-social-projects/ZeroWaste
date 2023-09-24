# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:diapers_calculator) { create(:calculator, name: "Diapers Calculator", slug: "diapers") }
  let!(:napkin_calculator) { create(:calculator, name: "Napkin Calculator", slug: "napkin") }

  before do
    @admin = create(:user, :admin)
    sign_in @admin
  end

  it "visits admin page" do
    visit account_calculators_path

    expect(page).to have_content diapers_calculator.name
    expect(page).to have_content napkin_calculator.name
  end

  context "with sorting" do
    it "by id asc" do
      visit account_calculators_path
      select(I18n.t("sort.id_asc"), from: "sort-selector")

      expect(page.find("#calculators > :first-child > :nth-child(3)")).to have_content Calculator.first.name
      expect(page.find("#calculators > :last-child > :nth-child(3)")).to have_content Calculator.last.name
    end

    it "by id desc" do
      visit account_calculators_path
      select(I18n.t("sort.id_desc"), from: "sort-selector")

      expect(page.find("#calculators > :first-child > :nth-child(3)")).to have_content Calculator.last.name
      expect(page.find("#calculators > :last-child > :nth-child(3)")).to have_content Calculator.first.name
    end
  end
end
