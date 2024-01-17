class Calculators::DiaperUsageService
  attr_accessor :age, :used_diapers_amount, :to_be_used_diapers_amount,
                :used_diapers_price, :to_be_used_diapers_price

  def initialize(years, month, category_id)
    @age                             = years.to_i * 12 + month.to_i
    @category_id                     = category_id
    @used_diapers_amount             = 0
    @to_be_used_diapers_amount       = 0
    @used_diapers_price              = 0
    @to_be_used_diapers_price        = 0
  end

  def calculate
    used_diapers_amount_all_periods = 0
    used_diapers_price_all_periods  = 0

    life_periods = LifePeriod.all.includes(:diaper_usages)
    prices       = Price.where(priceable_type: "DiaperUsage", category_id: @category_id)

    life_periods.each do |life_period|
      diaper_usage = life_period.diaper_usages.first
      next unless diaper_usage

      price = prices.find { |p| p.priceable_id == diaper_usage.id }
      next unless price

      quantity_in_period = diaper_usage.quantity_per_day * 30.5 * life_period.month_range.size
      cost_in_period     = quantity_in_period * price.sum

      used_diapers_amount_all_periods += quantity_in_period
      used_diapers_price_all_periods  += cost_in_period

      if life_period.month_range.first <= age
        months_in_period   = [age, life_period.month_range.last].min - life_period.month_range.first + 1
        quantity_in_period = diaper_usage.quantity_per_day * 30.5 * months_in_period
        cost_in_period     = quantity_in_period * price.sum

        @used_diapers_amount += quantity_in_period
        @used_diapers_price  += cost_in_period
      end
    end

    @to_be_used_diapers_amount = used_diapers_amount_all_periods - used_diapers_amount
    @to_be_used_diapers_price  = used_diapers_price_all_periods - used_diapers_price
    self
  end
end
