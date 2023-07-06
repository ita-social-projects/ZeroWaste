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
    when "new" then (0..11).to_a
    end
  end

  def old_results_data
    [
      { image: "diapers_to_buy.png", data_target: "diapersToBeUsed", locale: I18n.t("calculators.calculator.will_buy_diapers")},
      { image: "diapers_bought.png", data_target: "diapersUsed", locale: I18n.t("calculators.calculator.bought_diapers")},
      { image: "money_to_spent.png", data_target: "moneyWillBeSpent", locale: I18n.t("calculators.calculator.money_will_be_spent")},
      { image: "money_spent.png", data_target: "moneySpent", locale: I18n.t("calculators.calculator.money_spent")},
    ]
  end
end
