class Api::V2::CalculatorsController < Api::V2::ApplicationController
  def index
    calculators = collection.order_by_name(permitted_params[:name])

    render json: CalculatorsSerializerService.call(calculators)
  end

  def calculate
    @calculator = resource
    @validation = ConstructorCalculatorValidator.new(prepare_params, @calculator)

    if @validation.valid?
      calc_service = Calculators::CalculationService.new(@calculator, calculate_params_with_categories_converted)
      results      = calc_service.perform

      render json: results, status: :ok
    else
      render json: { errors: @validation.errors }, status: :unprocessable_entity
    end
  end

  private

  def prepare_params
    params.permit(resource.fields.pluck(:var_name).map(&:to_sym).push(:locale, :slug))
  end

  def category_fields_with_categories
    resource.fields.where(kind: "category").includes(:categories)
  end

  def calculate_params_with_categories_converted
    params = prepare_params

    all_categories                  = category_fields_with_categories.flat_map(&:categories)
    categories_by_field_and_en_name = all_categories.index_by { |category| [category.field_id, category.en_name] }

    category_fields_with_categories.each do |field|
      key                    = [field.id, params[field.var_name]]
      category               = categories_by_field_and_en_name[key]
      params[field.var_name] = category&.price
    end

    params
  end

  def resource
    collection.find_by(slug: params[:slug])
  end

  def permitted_params
    params.permit(:name)
  end

  def collection
    Calculator.all
  end
end
