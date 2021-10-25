# frozen_string_literal: true

class DiapersPerMonth
  def call(month, data)
    sum = 0
    (month + 1).times do |i|
      set = data.find { |months, _| months.include?(i) }
      sum += set[1] if set
    end
    sum
  end
end

