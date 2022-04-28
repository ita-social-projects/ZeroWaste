# frozen_string_literal: true

module Calculators
  class DiapersService
    DIAPERS_PER_MONTH = {
      (1..3) =>
        { price: 1220,
          amount: 305 },
      (4..6) =>
        { price: 1098,
          amount: 244 },
      (7..9) =>
        { price: 915,
          amount: 183 },
      (10..12) =>
        { price: 1006.5,
          amount: 183 },
      (13..18) =>
        { price: 671,
          amount: 122 },
      (19..24) =>
        { price: 732,
          amount: 122 },
      (25..30) =>
        { price: 366,
          amount: 61 }
    }.freeze

    attr_reader :age, :used_diapers_amount, :to_be_used_diapers_amount,
                :used_diapers_price, :to_be_used_diapers_price

    def initialize(age)
      @age = age
      @used_diapers_amount = 0
      @to_be_used_diapers_amount = 4575
      @used_diapers_price = 0
      @to_be_used_diapers_price = 23_332.5
    end

    def calculate!
      DIAPERS_PER_MONTH.each_key do |key|
        if key.last <= @age
          change(key, key.size)
        elsif key.include? @age
          change(key, @age - key.first + 1)
        end
      end
      @to_be_used_diapers_amount -= used_diapers_amount
      @to_be_used_diapers_price -= used_diapers_price
      self
    end

    private

    def change(size, coef)
      @used_diapers_amount += DIAPERS_PER_MONTH[size][:amount] * coef
      @used_diapers_price += DIAPERS_PER_MONTH[size][:price] * coef
    end

    def calculate_months(age)
      date = age.split('-')
      ((Time.now - Time.new(date[0], date[1], date[2])) / 2_635_200).round
    end
  end
end
