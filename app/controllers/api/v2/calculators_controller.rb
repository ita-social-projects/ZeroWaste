class Api::V2::CalculatorsController < Api::V2::ApplicationController
  def index
    calculators = collection.order_by_name(permitted_params[:name])

    render json: CalculatorsSerializerService.call(calculators)
  end

  private

  def permitted_params
    params.permit(:name)
  end

  def collection
    Calculator.all
  end
end
