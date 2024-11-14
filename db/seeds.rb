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

categories_data["categories"].each do |category_data|
  next if Category.exists?(en_name: category_data["en_name"])

  periods  = category_data.delete("periods")
  category = Category.create!(**category_data)

  periods.map! { |period_data| period_data.merge(category_id: category.id) }
  periods.each { |period_data| DiapersPeriod.create!(**period_data) }
end
