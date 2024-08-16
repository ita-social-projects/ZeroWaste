# frozen_string_literal: true

class Api::V1::CalculatorsController < ApplicationController
  def calculate
    @validation = CalculatorValidator.new(params)

    if @validation.valid?
      result = Calculators::CalculateService.new(product_resource, calculator_params).calculate

      render json: result.to_json, status: :ok
    else
      render json: { error: @validation.error }, status: :unprocessable_entity
    end
  end

  private

  def collection
    Calculator.ordered_by_name
  end

  def resource
    collection.friendly.find(params[:slug])
  end

  def calculator_params
    params.permit(:period, :price_id)
  end

  def product_resource
    Product.find(resource.product_id)
  end
end
