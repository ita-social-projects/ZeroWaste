# frozen_string_literal: true

require "rails_helper"

describe "visit admin page", js: true do
  let!(:budgetary) { create(:category, :budgetary) }
  let!(:medium) { create(:category, :medium) }

  include_context :authorize_admin

  it "visits admin page" do
    visit account_categories_path

    expect(page).to have_content budgetary.name
    expect(page).to have_content medium.name
  end
end
