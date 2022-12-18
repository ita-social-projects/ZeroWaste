# frozen_string_literal: true

class Calculators::DiapersService
  attr_accessor :age, :used_diapers_amount, :to_be_used_diapers_amount,
                :used_diapers_price, :to_be_used_diapers_price, :config

  def initialize(age)
    @age                       = age.to_i
    @used_diapers_amount       = 0
    @to_be_used_diapers_amount = 0
    @used_diapers_price        = 0
    @to_be_used_diapers_price  = 0
    @config                    = AppConfig.instance.diapers_calculator
    total
  end

  def calculate!
    @config.each_key do |key|
      key = to_range key
      if key.last <= @age
        change(key, key.size)
      elsif key.include? @age
        change(key, @age - key.first + 1)
      end
    end
    @to_be_used_diapers_amount -= used_diapers_amount
    @to_be_used_diapers_price  -= used_diapers_price
    self
  end

  private

  def change(period, coef)
    @used_diapers_amount += month_amount(period) * coef
    @used_diapers_price  += month_price(period) * coef
  end

  def to_range(str)
    arr = str.split("..").map { |d| Integer(d) }
    arr[0]..arr[1]
  end

  def total
    @config.each do |key, value|
      @to_be_used_diapers_amount += value["amount"].to_f * 30.5 *
        to_range(key).size
      @to_be_used_diapers_price  +=
        value["amount"].to_f * value["price"].to_f * 30.5 * to_range(key).size
    end
  end

  def month_amount(period)
    @config[period.to_s]["amount"].to_f * 30.5
  end

  def month_price(period)
    month_amount(period) * @config[period.to_s]["price"].to_f
  end
end
