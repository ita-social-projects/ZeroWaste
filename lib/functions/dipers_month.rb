# frozen_string_literal: true

class Dipers
  def dipers_per_month(x, data = {})
    sum = 0
    data.each do |key, value|
      sum += value if key <= x
    end
    p sum
  end
end
