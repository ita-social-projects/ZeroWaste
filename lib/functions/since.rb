# frozen_string_literal: true

class Since
  def self.calculate_units
    ->(from, to, unit) { get_diff_of_date(from, to, unit) }
  end

  def self.get_diff_of_date(from, to, unit)
    validate_date_format!(from, to)
    validate_unit!(unit)
    diff = to.to_time - from.to_time
    distance = diff / 1.send(unit)
    distance.abs.round
  end

  def self.validate_date_format!(from, to)
    return if from.is_a?(Date) && to.is_a?(Date)

    raise ArgumentError, 'invalid date format'
  end

  def self.validate_unit!(unit)
    return if 1.respond_to?(unit)

    raise ArgumentError, "#{unit.inspect} is not supported as unit"
  end
end
