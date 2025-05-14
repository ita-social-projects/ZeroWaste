class Api::V2::CalculatorsController < Api::V2::ApplicationController
  def index
    calculators = collection.order_by_name(params[:name])

    render json: CalculatorsSerializer.call(calculators)
  end

  def calculate
    @calculator = resource
    @validation = ConstructorCalculatorValidator.new(calculate_params, @calculator)

    if @validation.valid?
      calc_service = Calculators::Api::V2::CalculationService.new(@calculator, calculate_params_with_categories_converted)

      calc_service.perform

      render json: calc_service.results, status: :ok
    else
      render json: { errors: @validation.errors }, status: :unprocessable_entity
    end
  end

  private

  def calculate_params
    params.permit(resource.fields.map { |field| field.var_name.to_sym }.push(:locale, :slug))
  end

  def category_fields_name
    resource.fields.where(kind: "category").map(&:var_name)
  end

  def calculate_params_with_categories_converted
    params = calculate_params
    params.each do |field, value|
      next unless category_fields_name.include?(field)

      params[field] = resource
                       .fields.find_by(var_name: field)
                       .categories.find_by(en_name: value)
                       .price
    end
  end

  def resource
    collection.find_by(slug: params[:slug])
  end

  def collection
    Calculator.all
  end
end
