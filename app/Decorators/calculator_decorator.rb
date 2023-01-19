class CalculatorDecorator
  def initialize(result)
    @result = result
  end

  def for_json
    {
      result: get_values,
      date: get_date,
      text_products_to_be_used: get_text_products_to_be_used,
      text_products_used: get_text_products_used
    }
  end

  private

  def get_values
    {
      money_spent: @result.used_diapers_price,
      money_will_be_spent: @result.to_be_used_diapers_price,
      used_diapers_amount: @result.used_diapers_amount,
      to_be_used_diapers_amount: @result.to_be_used_diapers_amount
    }
  end

  def get_date
    @result.age
  end

  def get_text_products_to_be_used
    "#{word_form_to_be_used} #{I18n.t("calculators.calculator.will_buy_diapers")}"
  end

  def get_text_products_used
    "#{word_form_used} #{I18n.t("calculators.calculator.bought_diapers")}"
  end

  def word_form_to_be_used
    I18n.t("calculators.calculator.diaper").pluralize(
      count: @result.to_be_used_diapers_amount,
      locale: I18n.locale
    )
  end

  def word_form_used
    I18n.t("calculators.calculator.diaper").pluralize(
      count: @result.used_diapers_amount,
      locale: I18n.locale
    )
  end
end
