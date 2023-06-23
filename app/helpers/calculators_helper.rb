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
    (0..2).map { |year| "#{year} #{t("datetime.prompts.year").downcase.pluralize(count: year, locale: I18n.locale)}" }
  end

  def month_number
    (0..11).map { |month| "#{month} #{t("datetime.prompts.month").downcase.pluralize(count: month, locale: I18n.locale)}" }
  end
end
