# frozen_string_literal: true

class NamedValue < Field
  with_options if: :persisted? do
    validates :name, length: { minimum: 2 }
    validates :from, :to, numericality: { only_integer: true }
  end
end
