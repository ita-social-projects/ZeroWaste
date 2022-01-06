# frozen_string_literal: true

class RangeField < Field
  with_options if: :persisted? do
    validates :value, length: { minimum: 1 }
    validates :from, :to, numericality: { only_integer: true }
  end
end
