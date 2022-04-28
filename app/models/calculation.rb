# frozen_string_literal: true

class Calculation < Field
  validates :value, length: { minimum: 2 }
end
