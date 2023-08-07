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

# Create a calculator with related objects
bud_category = Category.find_or_create_by(name: "budgetary")
mid_category = Category.find_or_create_by(name: "medium")

product = Product.find_or_create_by(title: "Napkin")

bud_price = Price.find_or_create_by(priceable: product, category: bud_category, sum: 7)
mid_price = Price.find_or_create_by(priceable: product, category: mid_category, sum: 15)

calculator = Calculator.find_or_create_by(name: "Napkins Calculator", product: product)
