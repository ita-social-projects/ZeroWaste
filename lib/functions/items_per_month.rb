# frozen_string_literal: true

class ItemsPerMonth
  def self.deferred
    lambda do |month, *range_ids|
      ranges = RangeField.where(selector: range_ids.map(&:upcase))
      function = new(month)
      function.call(function.calculate_data(ranges))
    end
  end

  def initialize(month)
    @month = month
  end

  def call(data)
    sum = 0
    (month.to_i + 1).times do |i|
      set = data.find { |months, _| months.include?(i) }
      sum += set[1].to_f if set
    end

    sum
  end

  def calculate_data(ranges)
    ranges.each_with_object({}) do |range_field, res|
      res[(range_field.from..range_field.to)] = range_field.value
    end
  end

  private

  attr_reader :month
end
