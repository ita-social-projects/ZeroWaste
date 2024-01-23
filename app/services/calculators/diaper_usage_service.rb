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

    diapers_periods = DiapersPeriod.where(category_id: @category_id)

    diapers_periods.each do |diapers_period|
      quantity_in_period = diapers_period.usage_amount * 30.5 * (diapers_period.period_end - diapers_period.period_start + 1)
      cost_in_period     = quantity_in_period * diapers_period.price

      used_diapers_amount_all_periods += quantity_in_period
      used_diapers_price_all_periods  += cost_in_period

      if diapers_period.period_start <= @age
        months_in_period   = [age, diapers_period.period_end].min - diapers_period.period_start + 1
        quantity_in_period = diapers_period.usage_amount * 30.5 * months_in_period
        cost_in_period     = quantity_in_period * diapers_period.price

        @used_diapers_amount += quantity_in_period
        @used_diapers_price  += cost_in_period
      end
    end

    @to_be_used_diapers_amount = used_diapers_amount_all_periods - used_diapers_amount
    @to_be_used_diapers_price  = used_diapers_price_all_periods - used_diapers_price
    self
  end
end
