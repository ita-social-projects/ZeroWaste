# frozen_string_literal: true

class ItemsPerMonth
  def self.deferred
    ->(month, *range_ids) { new(month, range_ids).call }
  end

  def initialize(month, range_ids)
    @month = month
    @ranges = Field.where(selector: range_ids.map(&:upcase))
  end

  def call
    sum = 0
    data = calculate_data
    (month + 1).times do |i|
      set = data.find { |months, _| months.include?(i) }
      sum += set[1].to_i if set
    end

    sum
  end

  private

  attr_reader :month, :ranges

  def calculate_data
    validate_ranges_instances!(ranges)

    ranges.each_with_object({}) do |range_field, res|
      res[(range_field.from..range_field.to)] = range_field.value
    end
  end

  def validate_ranges_instances!(ranges)
    return if ranges.all?(RangeField)

    raise ArgumentError, 'invalid array format from RangeField model'
  end
end

