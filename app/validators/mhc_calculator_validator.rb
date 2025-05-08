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
    return unless presence_valid?(:user_age)

    length_valid?(:user_age, 1, 100)
  end

  def validate_menstruation_age
    return unless presence_valid?(:menstruation_age)

    length_valid?(:menstruation_age, 1, 100)
  end

  def validate_menopause_age
    return unless presence_valid?(:menopause_age)

    length_valid?(:menopause_age, 1, 100)
  end

  def validate_average_menstruation_cycle_duration
    return unless presence_valid?(:average_menstruation_cycle_duration)

    length_valid?(:average_menstruation_cycle_duration, 1, 100)
  end

  def validate_pads_per_cycle
    return unless presence_valid?(:pads_per_cycle)

    length_valid?(:pads_per_cycle, 1, 100)
  end

  def validate_pad_category
    return unless presence_valid?(:pad_category)

    category_valid?(:pad_category)
  end

  def presence_valid?(param)
    return true if @params[param].present?

    @errors[param] = I18n.t("calculators.errors.presence_error_msg", field: I18n.t("calculators.mhc_calculator.form.#{param}"))

    false
  end

  def length_valid?(param, from, to)
    return true if (from..to).cover?(@params[param].to_i)

    @errors[param] = I18n.t("calculators.errors.length_error_msg", field: I18n.t("calculators.mhc_calculator.form.#{param}"), from: from, to: to)

    false
  end

  def category_valid?(param)
    valid_categories = Calculators::PadUsageService::PAD_PRICES.keys.map(&:to_s)

    return true if valid_categories.include?(@params[param])

    @errors[param] = I18n.t("calculators.errors.category_error_msg", field: I18n.t("calculators.mhc_calculator.form.#{param}"))

    false
  end
end
