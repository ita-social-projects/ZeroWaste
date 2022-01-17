# frozen_string_literal: true

class Select < Field
  validates :label, length: { minimum: 2 }
end
