# frozen_string_literal: true

class Calculator < ApplicationRecord
  extend FriendlyId

  DIAPERS_PER_MONTH = { 3 => 10, 6 => 8, 12 => 6, 24 => 4, 30 => 2 }.freeze
  COST_PER_MONTH = { 3 => 4, 6 => 4.5, 9 => 5, 18 => 5.5, 30 => 6 }.freeze

  friendly_id :name, use: :slugged
  has_many :fields
  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/,
                             message: 'Only letters and numbers allowed' }
  validates :name, length: { minimum: 2 }
  validates :name, uniqueness: true

  def diapers_used(birthday)
    past_counting(birthday) { |days, months| diapers_per_month(days, months) }
  end

  def money_spent(birthday)
    past_counting(birthday) { |days, months| cost_per_month(days, months) }
  end

  def diapers_will_use(birthday)
    future_counting(birthday) { |days, months| diapers_per_month(days, months) }
  end

  def money_will_spend(birthday)
    future_counting(birthday) { |days, months| cost_per_month(days, months) }
  end

  private

  def diapers_per_month(days_in_month, month)
    closest_right_count = DIAPERS_PER_MONTH
                          .keys
                          .find { |right_value| right_value >= month }
    days_in_month * DIAPERS_PER_MONTH[closest_right_count]
  end

  def cost_per_month(days_in_month, month)
    closest_right_cost = COST_PER_MONTH
                         .keys
                         .find { |right_value| right_value >= month }
    diapers_per_month(days_in_month, month) * COST_PER_MONTH[closest_right_cost]
  end

  def past_counting(birthday)
    return 0 if birthday.blank?

    date = Date.parse(birthday)
    month = 0
    sum = 0

    while date.next_month < Date.current
      days = (date.next_month - date).to_i
      sum += yield(days, month)
      date = date.next_month
      month += 1
      return sum if month > 30
    end

    days = (Date.current - date).to_i
    sum + yield(days, month)
  end

  def future_counting(birthday)
    return 0 if birthday.blank?

    birthday_date = Date.parse(birthday)
    month = 0
    sum = 0

    while birthday_date.next_month < Date.current
      birthday_date = birthday_date.next_month
      month += 1
    end

    return 0 if month > 30

    next_month_date = Date.parse(birthday).next_month(month + 1)
    days = (next_month_date - Date.current).to_i
    sum += yield(days, month)

    while month < 30
      month += 1
      days_in_month = (next_month_date.next_month - next_month_date).to_i
      sum += yield(days_in_month, month)
      next_month_date = next_month_date.next_month
    end
    sum
  end

end
