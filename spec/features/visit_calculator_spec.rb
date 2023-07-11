# frozen_string_literal: true

require "rails_helper"

describe "visit Calculator page", js: true do
  let(:user) { create(:user) }
  let(:calculator) { create(:calculator) }

  # TODO: uncomment and impove or delete if useless

  # it "visits calculator page" do
  #   visit "/calculators/#{calculator.slug}"

  #   expect(page).to have_content "Child’s age"
  # end

  it "visits calculator page and open log_in page" do
    create(:feature_flag, :show_admin_menu)
    visit "/calculators/#{calculator.slug}"
    click_link("Log In")
    sleep 3
    expect(page).to have_content "Forgot your password"
  end
end
