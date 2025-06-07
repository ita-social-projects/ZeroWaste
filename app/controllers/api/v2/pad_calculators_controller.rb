class Api::V2::PadCalculatorsController < Api::V2::ApplicationController
  def calculate
    @validation = MhcCalculatorValidator.new(calculate_params)

    if @validation.valid?
      calc_service = Calculators::PadUsageService.new(**pad_attributes)

      render json: calc_service.calculate, status: :ok
    else
      render json: { errors: @validation.errors }, status: :unprocessable_entity
    end
  end

  private

  def pad_attributes
    {
      user_age: calculate_params[:user_age].to_i,
      menstruation_age: calculate_params[:menstruation_age].to_i,
      menopause_age: calculate_params[:menopause_age].to_i,
      average_menstruation_cycle_duration: calculate_params[:average_menstruation_cycle_duration].to_i,
      duration_of_menstruation: calculate_params[:duration_of_menstruation].to_i,
      disposable_products_per_day: calculate_params[:disposable_products_per_day].to_i,
      product_type: calculate_params[:product_type],
      pad_category: calculate_params[:pad_category]
    }
  end

  def calculate_params
    params.permit(
      :locale,
      :user_age,
      :menstruation_age,
      :menopause_age,
      :average_menstruation_cycle_duration,
      :duration_of_menstruation,
      :disposable_products_per_day,
      :product_type,
      :pad_category
    )
  end
end
