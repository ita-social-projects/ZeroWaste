class CalculatorDecorator
  attr_reader :result

  def initialize(result)
    @result = result
  end

  def to_json
    {
      result: results,
      date: age,
      text_products_to_be_used: text_products_to_be_used,
      text_products_used: text_products_used
    }
  end

  private

  def results
    {
      money_spent: result.used_diapers_price.round(1),
      money_will_be_spent: result.to_be_used_diapers_price.round(1),
      used_diapers_amount: result.used_diapers_amount,
      to_be_used_diapers_amount: result.to_be_used_diapers_amount,
      used_diapers_amount_pluralize: I18n.t("calculators.#{calculator_type}_calculator.bought_diapers",
                                            count: result.used_diapers_amount.ceil),
      to_be_diapers_amount_pluralize: I18n.t("calculators.#{calculator_type}_calculator.will_buy_diapers",
                                             count: result.to_be_used_diapers_amount.ceil)
    }.transform_values(&:to_s)
  end

  def age
    @result.age
  end

  def text_products_to_be_used
    "#{@result.to_be_used_diapers_amount} #{I18n.t("calculators.#{calculator_type}_calculator.will_buy_diapers")}"
  end

  def text_products_used
    "#{@result.used_diapers_amount} #{I18n.t("calculators.#{calculator_type}_calculator.bought_diapers")}"
  end

  def calculator_type
    Flipper[:new_calculator_design].enabled? ? "new" : "old"
  end
end
