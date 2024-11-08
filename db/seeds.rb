# frozen_string_literal: true

require "faker"
require "factory_bot_rails"

# A regular user
unless User.exists?(email: "user@zw.com")
  User.create(
    email: "user@zw.com",
    password: "password",
    password_confirmation: "password",
    first_name: "John",
    last_name: "User",
    confirmed_at: DateTime.current,
    role: "user"
  )
end

# An admin
unless User.exists?(email: "admin@zw.com")
  User.create(
    email: "admin@zw.com",
    password: "ChangeMe1",
    password_confirmation: "ChangeMe1",
    first_name: "Admin",
    last_name: "Admin",
    confirmed_at: DateTime.current,
    role: "admin"
  )
end

FactoryBot.create(:product, :diaper) unless Product.exists?(title: "diaper")

# Categories
categories_data = YAML.load_file(Rails.root.join("db", "data", "categories.yml"))

def create_category_with_periods(*args)
  en_name, uk_name, priority, periods = args
  return if Category.exists?(en_name: en_name)

  category = Category.create!(en_name:, uk_name:, priority:)
  periods.each { |period| DiapersPeriod.create!(period.merge(category:)) }
end

categories_data["categories"].each do |category_data|
  create_category_with_periods(
    *category_data.slice("en_name", "uk_name", "priority", "periods").values
  )
end
