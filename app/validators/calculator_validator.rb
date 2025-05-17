# frozen_string_literal: true

class CalculatorValidator
  attr_reader :params, :error

  def initialize(params)
    @params = params
  end

  def valid?
    childs_years  = params.fetch(:childs_years, nil)
    childs_months = params.fetch(:childs_months, nil)
    category_id   = params.fetch(:category_id, nil)

    if childs_years.blank? && childs_months.blank?
      @error = I18n.t("calculators.errors.year_and_month_error_msg")
      false
    elsif childs_years.blank?
      @error = I18n.t("calculators.errors.year_error_msg")
      false
    elsif childs_months.blank?
      @error = I18n.t("calculators.errors.month_error_msg")
      false
    elsif category_id.blank?
      @error = I18n.t("calculators.errors.category_error_msg")
      false
    elsif category_resource.nil?
      @error = I18n.t("calculators.errors.category_not_found_error_msg")
      false
    else
      true
    end
  end

  private

  def category_resource
    Category.find_by(id: params[:category_id])
  end
end
