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
