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
    (0..2).map { |year| "#{year} #{t("datetime.prompts.year").downcase.pluralize(count: year, locale: I18n.locale)}" }
  end

  # TODO tap method

  def month_number(style)
    collection = (0..11).map { |month| t("calculators.date.months", count: month) } if style == "old"
    collection = (0..11).map(&:to_s) if style == "new"

    collection
  end
end
