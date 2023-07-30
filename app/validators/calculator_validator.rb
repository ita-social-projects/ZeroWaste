# frozen_string_literal: true

class CalculatorValidator
  attr_reader :params, :error

  def initialize(params)
    @params = params
  end

  def valid?
    period  = params.fetch(:period, nil)
    price_id = params.fetch(:price_id, nil)

    if period.blank? && price_id.blank?
      @error = I18n.t("calculators.errors.year_and_month_error_msg")
      false
    elsif period.blank?
      @error = I18n.t("calculators.errors.year_error_msg")
      false
    elsif price_id.blank?
      @error = I18n.t("calculators.errors.month_error_msg")
      false
    else
      true
    end
  end
end
