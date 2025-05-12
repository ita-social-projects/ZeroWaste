class Api::V2::CalculatorsController < Api::V2::ApplicationController
  def index
    calculators = collection.order_by_name(params[:name])

    render json: CalculatorsSerializer.call(calculators)
  end

  private

  def collection
    Calculator.all
  end
end
