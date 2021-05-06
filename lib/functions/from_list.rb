# frozen_string_literal: true

class FromList
  def self.call_params
    ->(range_field_arr) { get_hash(range_field_arr) }
  end

  private
  def self.get_hash(range_field_arr)
    validate_ranges_instances!(range_field_arr)
    range_field_arr.each_with_object({}) do |range_field, hash|
      hash[range_field] =
        { (range_field.from..range_field.to) => range_field.value }
    end
  end

  private
  def self.validate_ranges_instances!(range_field_arr)
    return if range_field_arr.all?(RangeField)

    raise ArgumentError, 'not instance of RangeField model'
  end
end
