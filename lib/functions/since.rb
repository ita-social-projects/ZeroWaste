# frozen_string_literal: true

class Since
  def self.calculate_units
    proc { |from, to, unit| get_diff_of_date(from, to, unit) }
  end

  def self.get_diff_of_date(from, to, unit)
    unless 1.respond_to?(unit)
      raise ArgumentError, "#{unit.inspect} is not supported as unit"
    end

    diff = to - from
    distance = diff / 1.send(unit)
    distance.abs.round
  end
end
