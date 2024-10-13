# frozen_string_literal: true

class DiaperCalculatorForm
  include ActiveModel::Model

  attr_accessor :childs_years, :childs_months

  validate :validate_child_age

  private

  def validate_child_age
    if childs_years.blank? && childs_months.blank?
      errors.add(:base, I18n.t("calculators.errors.year_and_month_error_msg"))
    elsif childs_years.blank?
      errors.add(:base, I18n.t("calculators.errors.year_error_msg"))
    elsif childs_months.blank?
      errors.add(:base, I18n.t("calculators.errors.month_error_msg"))
    end
  end
end
