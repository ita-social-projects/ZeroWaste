class ConstructorCalculatorValidator
  attr_reader :params, :errors

  def initialize(params, calculator)
    @params     = params
    @calculator = calculator
    @errors     = {}
    @fields     = @calculator.fields
  end

  def valid?
    @fields.each do |field|
      next unless presence_valid?(field)

      category_valid?(field) if category_field_names.include?(field.var_name)
    end

    errors.empty?
  end

  private

  def localized_field_label(field)
    return field.uk_label if @params[:locale] == "uk"

    field.en_label
  end

  def category_field_names
    @calculator.fields.where(kind: "category").map(&:var_name)
  end

  def valid_categories(field)
    @calculator.fields.find_by(var_name: field).categories.map(&:en_name)
  end

  def presence_valid?(field)
    return true if @params[field.var_name].present?

    @errors[field.var_name] = I18n.t("calculators.errors.presence_error_msg", field: localized_field_label(field))

    false
  end

  def category_valid?(field)
    valid_categories = valid_categories(field.var_name)

    return true if valid_categories.include?(@params[field.var_name])

    @errors[field.var_name] = I18n.t("calculators.errors.wrong_category_error_msg")

    false
  end
end
