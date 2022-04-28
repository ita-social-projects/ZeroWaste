# frozen_string_literal: true

class Value < Field
  validates :value, format: { with: /[a-zA-Z0-9]/ }
  validates :value, length: { minimum: 1 }
end
