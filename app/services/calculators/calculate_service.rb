# frozen_string_literal: true

class Calculators::CalculateService
  attr_accessor :product, :period, :items_used, :money_spent, :params

  DAYS = {
    "day" => 1,
    "week" => 7,
    "month" => 30.5,
    "year" => 365
  }.freeze

  def initialize(product, params)
    @product     = product
    @period      = DAYS[params[:period]]
    @items_used  = 0
    @money_spent = 0
    @params      = params
  end

  def calculate
    money_spent = (selected_price * period).to_i
    items_used  = (product.default_usage_per_day * period).to_i

    {
      moneySpent: money_spent,
      itemsUsed: items_used
    }
  end

  private

  def selected_price
    product.prices.find_by(category_id: params[:price_id]).sum
  end
end
