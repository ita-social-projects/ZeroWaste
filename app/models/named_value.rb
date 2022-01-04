# frozen_string_literal: true

class NamedValue < Field
  with_options if: :persisted? do
    validates :name, presence: true
    validates :name, length: { minimum: 2 }
  end
end
