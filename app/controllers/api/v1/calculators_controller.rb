# frozen_string_literal: true

class Api::V1::CalculatorsController < ApplicationController
  def calculate
    # @validation = CalculatorValidator.new(params)

    # if @validation.valid?
    # puts('=' * 30)
    # puts params
    # puts('=' * 30)

    result = Calculators::CalculateService.new(resource.product, calculator_params).calculate

    render json: result.to_json, status: :ok
    # else
    #   render(
    #     json: {
    #       error: @validation.error
    #     }, status: :unprocessable_entity
    #   )
    # end
  end

  private

  def collection
    Calculator.all
  end

  def resource
    collection.friendly.find(params[:slug])
  end

  def calculator_params
    params.permit(:period, :price_id)
  end
end
