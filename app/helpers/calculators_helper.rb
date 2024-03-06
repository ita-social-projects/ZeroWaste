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

  def new_calculator_items
    [{ image: "diapers_bought_2.png", data_target: "diapersUsed", unit: t(".pieces"), text_target: "boughtDiapersPluralize", text: t(".bought_diapers", count: 0) },
      "arrow",
      { image: "diapers_to_buy_2.png", data_target: "diapersToBeUsed", unit: t(".pieces"), text_target: "willBuyDiapersPluralize", text: t(".will_buy_diapers", count: 0) },
      { image: "money_spent_2.png", data_target: "moneySpent", unit: t(".unit"), text: t(".money_spent") },
      "arrow",
      { image: "money_to_spent_2.png", data_target: "moneyWillBeSpent", unit: t(".unit"), text: t(".money_will_be_spent") }]
  end

  def old_calculator_items
    [{ image: "diapers_to_buy.png", data_target: "diapersToBeUsed", text_target: "willBuyDiapersPluralize", text: t(".will_buy_diapers", count: 0) },
        { image: "diapers_bought.png", data_target: "diapersUsed", text_target: "boughtDiapersPluralize", text: t(".bought_diapers", count: 0) },
        { image: "money_to_spent.png", data_target: "moneyWillBeSpent", text: t(".money_will_be_spent") },
        { image: "money_spent.png", data_target: "moneySpent", text: t(".money_spent") }]
  end
end
