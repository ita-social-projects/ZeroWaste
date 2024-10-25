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
def create_category_with_periods(en_name, uk_name, periods)
  unless Category.exists?(en_name: en_name)
    category = Category.create!(en_name: en_name, uk_name: uk_name)

    periods.each do |period_data|
      DiapersPeriod.create!(period_data.merge(category: category))
    end
  end
end

# Budgetary category periods
create_category_with_periods("Budgetary", "Бюджетна", [
  { period_start: 1, period_end: 3, usage_amount: 10, price: 5.96 },
  { period_start: 4, period_end: 6, usage_amount: 8, price: 6.35 },
  { period_start: 7, period_end: 9, usage_amount: 6, price: 6.35 },
  { period_start: 10, period_end: 12, usage_amount: 6, price: 6.45 },
  { period_start: 13, period_end: 18, usage_amount: 4, price: 6.45 },
  { period_start: 19, period_end: 24, usage_amount: 4, price: 7.6 },
  { period_start: 25, period_end: 30, usage_amount: 2, price: 7.6 }
])

# Medium category periods
create_category_with_periods("Medium", "Середня", [
  { period_start: 1, period_end: 3, usage_amount: 10, price: 8.03 },
  { period_start: 4, period_end: 6, usage_amount: 8, price: 8.33 },
  { period_start: 7, period_end: 9, usage_amount: 6, price: 8.65 },
  { period_start: 10, period_end: 12, usage_amount: 6, price: 10.07 },
  { period_start: 13, period_end: 18, usage_amount: 4, price: 10.07 },
  { period_start: 19, period_end: 24, usage_amount: 4, price: 11.13 },
  { period_start: 25, period_end: 30, usage_amount: 2, price: 11.13 }
])

# Premium category periods
create_category_with_periods("Premium", "Преміум", [
  { period_start: 1, period_end: 3, usage_amount: 10, price: 11.41 },
  { period_start: 4, period_end: 6, usage_amount: 8, price: 12.59 },
  { period_start: 7, period_end: 9, usage_amount: 6, price: 14.18 },
  { period_start: 10, period_end: 12, usage_amount: 6, price: 18.52 },
  { period_start: 13, period_end: 18, usage_amount: 4, price: 18.52 },
  { period_start: 19, period_end: 24, usage_amount: 4, price: 18.62 },
  { period_start: 25, period_end: 30, usage_amount: 2, price: 18.62 }
])
