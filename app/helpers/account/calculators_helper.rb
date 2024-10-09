# frozen_string_literal: true

module Account::CalculatorsHelper
  def calculation_items
    [
      { image: "money_spent_2.png", data_target: "moneySpentResult", unit: t("calculators.results.money"), text: t("calculators.results.spent") },
      { image: "thrash_produced.png", data_target: "itemsUsedResult", unit: t("calculators.results.unit"), text: t("calculators.results.used") }
    ]
  end
end
