# frozen_string_literal: true

class Since
  def self.calculate_units
    ->(from, to, unit) { get_diff_of_date(from, to, unit) }
  end

  def self.get_diff_of_date(from, to, unit)
    valid_date_format!(from, to)
    valid_unit!(unit)
    diff = to - from
    distance = diff / 1.send(unit)
    distance.abs.round
  end

  def self.valid_date_format!(from, to)
    return if from.is_a?(Time) && to.is_a?(Time)

    raise ArgumentError, 'invalid date format'
  end

  def self.valid_unit!(unit)
    return if 1.respond_to?(unit)

    raise ArgumentError, "#{unit.inspect} is not supported as unit"
  end
end
