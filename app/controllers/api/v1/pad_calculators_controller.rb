class Api::V1::PadCalculatorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def calculate
    @validation = MhcCalculatorValidator.new(params)

    if @validation.valid?
      calc_service = Calculators::PadUsageService.new(
        user_age: params[:user_age],
        menstruation_age: params[:menstruation_age],
        menopause_age: params[:menopause_age],
        average_menstruation_cycle_duration: params[:average_menstruation_cycle_duration],
        pads_per_cycle: params[:pads_per_cycle],
        pad_category: params[:pad_category]
      )

      render json: calc_service.calculate, status: :ok
    else
      render json: { errors: @validation.errors }, status: :unprocessable_entity
    end
  end
end
