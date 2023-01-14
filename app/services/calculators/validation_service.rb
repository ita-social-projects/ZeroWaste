# frozen_string_literal: true

class Calculators::ValidationService
  def initialize(params)
    @params = params
  end

  def validate
    childs_years  = parse(:childs_years)
    childs_months = parse(:childs_months)

    childs_years  = childs_years[/^\d+$/] if childs_years.is_a? String
    childs_months = childs_months[/^\d+$/] if childs_months.is_a? String

    if childs_years.nil? && childs_months.nil?
      return {
        valid?: false,
        error: I18n.t("calculators.calculator.year_and_month_error_msg")
      }
    elsif childs_years.nil?
      return {
        valid?: false,
        error: I18n.t("calculators.calculator.year_error_msg")
      }
    elsif childs_months.nil?
      return {
        valid?: false,
        error: I18n.t("calculators.calculator.month_error_msg")
      }
    end

    { valid?: true }
  end

  private

  def parse(key)
    @params.fetch(key, nil)
  end
end
