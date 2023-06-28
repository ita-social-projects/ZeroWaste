# frozen_string_literal: true

module CalculatorsHelper
  def extract_max_selector(fields)
    fields.map { |field| field.selector&.gsub(/\D/, "").to_i }.max
  end

  def collection_product_category
    [t("calculators.calculator.form.budgetary"),
      t("calculators.calculator.form.medium"),
      t("calculators.calculator.form.premium")]
  end

  def years_number
    (0..2).map { |year| t("calculators.date.years", count: year) }
  end

  def month_number(style)
    case style

    when "old" then (0..11).map { |month| t("calculators.date.months", count: month) }
    when "new" then (0..11).map(&:to_s)

    end
  end
end
