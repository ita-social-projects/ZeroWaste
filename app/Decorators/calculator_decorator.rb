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
      money_spent: result.used_diapers_price,
      money_will_be_spent: result.to_be_used_diapers_price,
      used_diapers_amount: result.used_diapers_amount,
      to_be_used_diapers_amount: result.to_be_used_diapers_amount
    }
  end

  def age
    @result.age
  end

  def text_products_to_be_used
    "#{word_form_to_be_used} #{I18n.t("calculators.calculator.will_buy_diapers")}"
  end

  def text_products_used
    "#{word_form_used} #{I18n.t("calculators.calculator.bought_diapers")}"
  end

  # returns word should be used for amount of diapers to be used in the future
  def word_form_to_be_used
    I18n.t("calculators.calculator.diaper").pluralize(
      count: @result.to_be_used_diapers_amount,
      locale: I18n.locale
    )
  end

  # returns word should be used for amount of diapers have been used in the past
  def word_form_used
    I18n.t("calculators.calculator.diaper").pluralize(
      count: @result.used_diapers_amount,
      locale: I18n.locale
    )
  end
end
