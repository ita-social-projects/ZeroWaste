# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:budgetary) { create(:category, :budgetary) }
  let!(:medium) { create(:category, :medium) }

  before do
    @admin = create(:user, :admin)
    sign_in @admin
  end

  it "visits admin page" do
    visit account_categories_path

    expect(page).to have_content budgetary.name
    expect(page).to have_content medium.name
  end

  context "with sorting" do
    it "by id asc" do
      visit account_categories_path
      select(I18n.t("sort.id_asc"), from: "sort-selector")

      expect(page.find("#categories > :first-child > :nth-child(2)")).to have_content Category.first.name
      expect(page.find("#categories > :last-child > :nth-child(2)")).to have_content Category.last.name
    end

    it "by id desc" do
      visit account_categories_path
      select(I18n.t("sort.id_desc"), from: "sort-selector")

      expect(page.find("#categories > :first-child > :nth-child(2)")).to have_content Category.last.name
      expect(page.find("#categories > :last-child > :nth-child(2)")).to have_content Category.first.name
    end
  end
end
