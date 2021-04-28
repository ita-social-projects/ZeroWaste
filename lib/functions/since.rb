# frozen_string_literal: true

class Since
  def self.calculate_units
    proc { |date, unit| define_case(date, unit) }
  end

  def self.define_case(date, unit)
    case unit
    when 'day'
      days_from(date)
    when 'month'
      months_from(date)
    when 'year'
      years_from(date)
    end
  end

  def self.days_from(date)
    (Date.today - date).to_i
  end

  def self.months_from(date)
    (Date.today.year * 12 + Date.today.month) - (date.year * 12 + date
.month)
  end

  def self.years_from(date)
    Date.today.year - date.year
  end
end
