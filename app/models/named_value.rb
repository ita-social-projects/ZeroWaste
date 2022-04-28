# frozen_string_literal: true

class NamedValue < Field
  validates :name, length: { minimum: 2 }
  validates :from, :to, numericality: { only_integer: true }
end
