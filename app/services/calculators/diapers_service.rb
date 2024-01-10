# frozen_string_literal: true

class Calculators::DiapersService
  attr_accessor :age, :used_diapers_amount, :to_be_used_diapers_amount,
                :used_diapers_price, :to_be_used_diapers_price, :config, :price_id

  def initialize(years, month, price_id)
    @age                       = years.to_i * 12 + month.to_i
    @price_id                  = price_id || 1
    @used_diapers_amount       = 0
    @to_be_used_diapers_amount = 0
    @used_diapers_price        = 0
    @to_be_used_diapers_price  = 0
    @config                    = AppConfig.instance.diapers_calculator[@price_id.to_s]
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

  def self.product_attributes(params)
    {
      (1..3) => {
        amount: params[:first_amount],
        price: params[:first_price]
      },
      (4..6) => {
        amount: params[:second_amount],
        price: params[:second_price]
      },
      (7..9) => {
        amount: params[:third_amount],
        price: params[:third_price]
      },
      (10..12) => {
        amount: params[:fourth_amount],
        price: params[:fourth_price]
      },
      (13..18) => {
        amount: params[:fifth_amount],
        price: params[:fifth_price]
      },
      (19..24) => {
        amount: params[:sixth_amount],
        price: params[:sixth_price]
      },
      (25..30) => {
        amount: params[:seventh_amount],
        price: params[:seventh_price]
      }
    }
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
