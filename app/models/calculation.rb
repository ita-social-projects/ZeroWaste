# frozen_string_literal: true

class Calculation < Field
  with_options if: :persisted? do
    validates_presence_of :value
    validates :value, length: { minimum: 2 }
  end
end
