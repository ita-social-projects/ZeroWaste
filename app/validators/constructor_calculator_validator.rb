class ConstructorCalculatorValidator
  attr_reader :params, :errors

  def initialize(params, calculator)
    @params     = params
    @calculator = calculator
    @errors     = {}
    @fields     = calculator.fields
  end

  def valid?
    @fields.each do |field|
      next unless presence_valid?(field)

      category_valid?(field) if category_fields.include?(field.var_name)
    end

    errors.blank?
  end

  private

  def localized_field_label(field)
    return field.uk_label if @params[:locale] == "uk"

    field.en_label
  end

  def category_fields
    @fields.where(kind: "category").map(&:var_name)
  end

  def valid_categories(var_name)
    @fields.find_by(var_name: var_name).categories.map(&:en_name)
  end

  def presence_valid?(field)
    name = field.var_name
    return true if @params[name].present?

    @errors[name] = I18n.t("calculators.errors.presence_error_msg", field: localized_field_label(field))
    false
  end

  def category_valid?(field)
    name       = field.var_name
    categories = valid_categories(name)
    return true if categories.include?(@params[name])

    @errors[name] = I18n.t("calculators.errors.wrong_category_error_msg")
    false
  end
end
