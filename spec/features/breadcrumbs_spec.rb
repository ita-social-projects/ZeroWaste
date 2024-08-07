require "rails_helper"

RSpec.feature "Breadcrumbs", type: :feature do
  it "display breadcrumbs on the about page" do
    visit about_path

    expect(page).to have_css("nav.breadcrumbs")

    within("nav.breadcrumbs") do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_content("About Us")
    end
  end

  it "display breadcrumbs on the contact us page" do
    visit new_message_path

    expect(page).to have_css("nav.breadcrumbs")

    within("nav.breadcrumbs") do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_content("Contact us")
    end
  end

  it "display breadcrumbs on the new diaper calculator page" do
    visit calculator_path

    expect(page).to have_css("nav.breadcrumbs")

    within("nav.breadcrumbs") do
      expect(page).to have_link("Home", href: root_path)
      expect(page).to have_content("Diaper calculator")
    end
  end
end
