class Api::V1::PadCalculatorsController < ApplicationController
  def calculate
    @validation = MhcCalculatorValidator.new(params)

    if @validation.valid?
      calc_service = Calculators::PadUsageService.new(
        user_age: params[:user_age],
        menstruation_age: params[:menstruation_age],
        menopause_age: params[:menopause_age],
        average_menstruation_cycle_duration: params[:average_menstruation_cycle_duration],
        duration_of_menstruation: params[:duration_of_menstruation],
        disposable_products_per_day: params[:disposable_products_per_day],
        product_type: params[:product_type],
        pad_category: params[:pad_category]
      )

      render json: calc_service.calculate, status: :ok
    else
      render json: { errors: @validation.errors }, status: :unprocessable_entity
    end
  end
end
