# frozen_string_literal: true

module CalculatorsHelper
  def extract_max_selector(fields)
    fields.map { |field| field.selector&.gsub(/\D/, "").to_i }.max
  end

  def collection_product_category
    [t(".form.budgetary"),
      t(".form.medium"),
      t(".form.premium")]
  end

  def years_number
    (0..2).map { |year| t("calculators.date.years", count: year) }
  end

  def month_number(style)
    case style
    when "old" then (0..11).map { |month| t("calculators.date.months", count: month) }
    when "new" then (0..11).to_a
    end
  end

  def use_period
    [
      [I18n.t("calculators.date.day"), "day"],
      [I18n.t("calculators.date.week"), "week"],
      [I18n.t("calculators.date.month"), "month"],
      [I18n.t("calculators.date.year"), "year"]
    ]
  end

  def product_prices(calculator)
    calculator.product.prices.map { |price| [price.category.name, price.id] }
  end
end
