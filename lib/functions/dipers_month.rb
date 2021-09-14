# frozen_string_literal: true

class Dipers
  def dipers_per_month(x, data)
    sum = 0
    (x + 1).times do |i|
      set = data.find { |months, _| months.include?(i) }
      sum += set[1] if set
    end
    sum
  end
end

