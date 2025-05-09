class Api::V2::PadCalculatorsController < Api::V2::ApplicationController
  def calculate
    @validation = MhcCalculatorValidator.new(calculate_params)

    if @validation.valid?
      calc_service = Calculators::PadUsageService.new(
        user_age: calculate_params[:user_age],
        menstruation_age: calculate_params[:menstruation_age],
        menopause_age: calculate_params[:menopause_age],
        average_menstruation_cycle_duration: calculate_params[:average_menstruation_cycle_duration],
        pads_per_cycle: calculate_params[:pads_per_cycle],
        pad_category: calculate_params[:pad_category]
      )

      render json: calc_service.calculate, status: :ok
    else
      render json: { errors: @validation.errors }, status: :unprocessable_entity
    end
  end

  private

  def calculate_params
    params.permit(
      :locale,
      :user_age,
      :menstruation_age,
      :menopause_age,
      :average_menstruation_cycle_duration,
      :pads_per_cycle,
      :pad_category
    )
  end
end
