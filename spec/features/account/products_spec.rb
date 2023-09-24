# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:diaper) { create(:product, :diaper) }
  let!(:napkin) { create(:product, :napkin) }

  before do
    @admin = create(:user, :admin)
    sign_in @admin
  end

  it "visits admin page" do
    visit account_products_path

    expect(page).to have_content diaper.title
    expect(page).to have_content napkin.title
  end

  context "with sorting" do
    it "by id asc" do
      visit account_products_path
      select(I18n.t("sort.id_asc"), from: "sort-selector")

      expect(page.find("#products > :first-child > :nth-child(2)")).to have_content Product.first.title
      expect(page.find("#products > :last-child > :nth-child(2)")).to have_content Product.last.title
    end

    it "by id desc" do
      visit account_products_path
      select(I18n.t("sort.id_desc"), from: "sort-selector")

      expect(page.find("#products > :first-child > :nth-child(2)")).to have_content Product.last.title
      expect(page.find("#products > :last-child > :nth-child(2)")).to have_content Product.first.title
    end
  end
end
