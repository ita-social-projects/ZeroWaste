# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the
# Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Default site settings initialization
site_setting       = SiteSetting.instance
site_setting.title = "ZeroWaste"
site_setting.favicon.attach(
  io: File.open("app/assets/images/logo_zerowaste.png"),
  filename: "logo_zerowaste.png",
  content_type: "image/png"
)

site_setting.save!

# A regular user
User.create(
  email: "user@zw.com",
  password: "password",
  password_confirmation: "password",
  first_name: "John",
  last_name: "User",
  confirmed_at: "2022-04-27 15:29:25.414540000 +0000",
  role: "user"
)

# An admin
User.create(
  email: "admin@zw.com",
  password: "ChangeMe1",
  password_confirmation: "ChangeMe1",
  first_name: "Admin",
  last_name: "Admin",
  confirmed_at: "2022-04-27 15:29:25.414540000 +0000",
  role: "admin"
)

FactoryBot.create(:product_type, :hygiene)
FactoryBot.create(:product, :diaper)

FeatureFlag.create!(
  name: "feature_budget_category",
  enabled: false
)

FeatureFlag.create!(
  name: "show_admin_menu",
  enabled: true
)
