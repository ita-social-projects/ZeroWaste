# frozen_string_literal: true

module Calculators
  class DiapersService
    DIAPERS_INFO = AppConfig.instance.diapers_calculator

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
      DIAPERS_INFO.each_key do |key|
        key = to_range key
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
      @used_diapers_amount += DIAPERS_INFO[size.to_s]['amount'] * coef * 30.5
      @used_diapers_price += DIAPERS_INFO[size.to_s]['amount'] * DIAPERS_INFO[size.to_s]['price'] * coef * 30.5
    end

    def to_range(str)
      arr = str.split('..').map {|d| Integer(d)}
      arr[0]..arr[1]
    end
  end
end
