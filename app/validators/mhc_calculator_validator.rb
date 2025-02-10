# frozen_string_literal: true

class MhcCalculatorValidator
  attr_reader :params, :errors

  def initialize(params)
    @params = params
    @errors = {}
  end

  def valid?
    validate_user_age
    validate_menstruation_age
    validate_menopause_age
    validate_average_menstruation_cycle_duration
    validate_duration_of_menstruation
    validate_disposable_products_per_day
    validate_pad_category

    errors.empty?
  end

  private

  def validate_user_age
    presence_valid?(:user_age)
  end

  def validate_menstruation_age
    presence_valid?(:menstruation_age)
  end

  def validate_menopause_age
    presence_valid?(:menopause_age)
  end

  def validate_average_menstruation_cycle_duration
    presence_valid?(:average_menstruation_cycle_duration)
  end

  def validate_duration_of_menstruation
    presence_valid?(:duration_of_menstruation)
  end

  def validate_disposable_products_per_day
    presence_valid?(:disposable_products_per_day)
  end

  def validate_pad_category
    presence_valid?(:pad_category)
  end

  def presence_valid?(param)
    return true if @params[param].present?

    @errors[param] = I18n.t("calculators.errors.presence_error_msg", field: I18n.t("calculators.mhc_calculator.form.#{param}"))

    false
  end
end
