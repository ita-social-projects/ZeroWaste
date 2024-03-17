# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def calculate
    @validation = CalculatorValidator.new(params)

    if @validation.valid?
      calc_service         = Calculators::DiaperUsageService.new(params[:childs_years], params[:childs_months], set_category_id)
      calc_service.calculate
      calculator_decorator = CalculatorDecorator.new(calc_service.result)

      render json: calculator_decorator.to_json, status: :ok
    else
      render json: { error: @validation.error }, status: :unprocessable_entity
    end
  end

  private

  def set_category_id
    params[:category_id].presence || Category.preferable.first.id
  end
end
