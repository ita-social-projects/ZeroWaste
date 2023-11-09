# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:diaper) { create(:product, :diaper) }
  let!(:napkin) { create(:product, :napkin) }

  include_context :authorize_admin

  it "visits admin page" do
    visit account_products_path

    expect(page).to have_content diaper.title
    expect(page).to have_content napkin.title
  end
end
