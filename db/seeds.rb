# frozen_string_literal: true

require "faker"
require "factory_bot_rails"

# A regular user
User.create(
  email: "user@zw.com",
  password: "password",
  password_confirmation: "password",
  first_name: "John",
  last_name: "User",
  confirmed_at: DateTime.current,
  role: "user"
) unless User.exists?(email:"user@zw.com")

# An admin
User.create(
  email: "admin@zw.com",
  password: "ChangeMe1",
  password_confirmation: "ChangeMe1",
  first_name: "Admin",
  last_name: "Admin",
  confirmed_at: DateTime.current,
  role: "admin"
) unless User.exists?(email:"admin@zw.com")

FactoryBot.create(:product_type, :hygiene)
FactoryBot.create(:product, :diaper)

FeatureFlag.find_or_create_by!(
  name: "feature_budget_category",
  enabled: false
)

FeatureFlag.find_or_create_by!(
  name: "show_admin_menu",
  enabled: false
)
