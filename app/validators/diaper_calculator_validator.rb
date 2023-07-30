# frozen_string_literal: true

class DiaperCalculatorValidator
  attr_reader :params, :error

  def initialize(params)
    @params = params
  end

  def valid?
    childs_years  = params.fetch(:childs_years, nil)
    childs_months = params.fetch(:childs_months, nil)

    if childs_years.blank? && childs_months.blank?
      @error = I18n.t("calculators.errors.year_and_month_error_msg")
      false
    elsif childs_years.blank?
      @error = I18n.t("calculators.errors.year_error_msg")
      false
    elsif childs_months.blank?
      @error = I18n.t("calculators.errors.month_error_msg")
      false
    else
      true
    end
  end
end
