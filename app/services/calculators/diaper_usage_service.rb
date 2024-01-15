class Calculators::DiaperUsageService
  def self.calculate_total_usage_and_cost(category_id, month)
    total_quantity = 0
    total_cost = 0

    life_periods = LifePeriod.all.includes(:diaper_usages)
    prices = Price.where(priceable_type: "DiaperUsage", category_id: category_id)

    (1..month).each do |m|
      life_periods.each do |life_period|
        next unless life_period.month_range.include?(m)

        diaper_usage = life_period.diaper_usages.first
        next unless diaper_usage

        quantity_in_period = diaper_usage.quantity_per_day * 30.5
        total_quantity += quantity_in_period

        price = prices.find { |p| p.priceable_id == diaper_usage.id }
        next unless price

        cost_in_period = quantity_in_period * price.sum
        total_cost += cost_in_period
      end
    end

    { total_quantity: total_quantity, total_cost: total_cost.to_i }
  end

  def self.find_diaper_usage(life_period)
    DiaperUsage.find_by(life_period: life_period)
  end

  def self.find_diaper_price(diaper_usage, category_id)
    Price.find_by(priceable: diaper_usage, category: category_id)
  end
end
