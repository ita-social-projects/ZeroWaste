# frozen_string_literal: true

class InClass
  def self.get_params
    ->(from, to, value) { get_hash(from, to, value) }
  end

  def self.get_hash(from, to, value)
    validate_from_to!(from, to)
    validate_value!(value)

    { (from..to) => value }
  end

  def validate_from_to!(_from)
    return if RangeField.from.is_a?(Array) && RangeField.to.is_a?(Array)

    raise ArgumentError, 'invalid array format'
  end

  def validate_value!(value)
    return if 1.respond_to?(value)

    raise ArgumentError, "#{value.inspect} is not supported as value"
  end
end
