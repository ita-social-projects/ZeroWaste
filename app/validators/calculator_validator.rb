# frozen_string_literal: true

class CalculatorValidator
  attr_reader :params, :error

  def initialize(params)
    @params = params
  end

  def valid?
    childs_years  = params.fetch(:childs_years, nil)
    childs_months = params.fetch(:childs_months, nil)

    if childs_years.blank? && childs_months.blank?
      @error = I18n.t("calculators.calculator.year_and_month_error_msg")
      false
    elsif childs_years.blank?
      @error = I18n.t("calculators.calculator.year_error_msg")
      false
    elsif childs_months.blank?
      @error = I18n.t("calculators.calculator.month_error_msg")
      false
    else
      true
    end
  end
end
