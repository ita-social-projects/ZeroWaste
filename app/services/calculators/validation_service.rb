# frozen_string_literal: true

class Calculators::ValidationService
  def initialize(params)
    @params = params
  end

  def validate
    childs_years  = @params.fetch(:childs_years, nil)
    childs_months = @params.fetch(:childs_months, nil)

    if childs_years.blank? && childs_months.blank?
      return {
        is_valid: false,
        error: I18n.t("calculators.calculator.year_and_month_error_msg")
      }
    elsif childs_years.blank?
      return {
        is_valid: false,
        error: I18n.t("calculators.calculator.year_error_msg")
      }
    elsif childs_months.blank?
      return {
        is_valid: false,
        error: I18n.t("calculators.calculator.month_error_msg")
      }
    end

    { is_valid: true }
  end
end
