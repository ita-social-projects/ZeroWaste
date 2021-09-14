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

# calc = Dipers.new
# p calc.dipers_per_month(0, {0..2 => 30, 3..5 => 70})
