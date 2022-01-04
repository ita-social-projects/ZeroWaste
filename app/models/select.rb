# frozen_string_literal: true

class Select < Field
  with_options if: :persisted? do
    validates :label, presence: true
    validates :label, length: { minimum: 2 }
  end
end
