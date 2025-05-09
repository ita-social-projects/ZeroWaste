class Api::V2::DiaperCalculatorsController < Api::V2::ApplicationController
  def calculate
    @validation = CalculatorValidator.new(calculate_params)

    if @validation.valid?
      calc_service = Calculators::DiaperUsageService.new(
        calculate_params[:childs_years],
        calculate_params[:childs_months],
        calculate_params[:category_id]
      )
      calc_service.calculate

      calculator_decorator = CalculatorDecorator.new(calc_service.result)
      render json: calculator_decorator.to_json, status: :ok
    else
      render json: { errors: @validation.error }, status: :unprocessable_entity
    end
  end

  private

  def calculate_params
    params.permit(:locale, :childs_years, :childs_months, :category_id)
  end
end
