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
    validate_pads_per_cycle
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

  def validate_pads_per_cycle
    presence_valid?(:pads_per_cycle)
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
