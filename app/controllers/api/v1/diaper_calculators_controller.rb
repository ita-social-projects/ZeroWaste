# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def calculate
    @form = DiaperCalculatorForm.new(calculator_params)

    if @form.valid?
      calc_service         = Calculators::DiaperUsageService.new(params[:childs_years], params[:childs_months], set_category_id)
      calc_service.calculate
      calculator_decorator = CalculatorDecorator.new(calc_service.result)

      render json: calculator_decorator.to_json, status: :ok
    else
      render json: { error: @form.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def set_category_id
    params[:category_id].presence || Category.preferable.first.id
  end

  def calculator_params
    params.permit(:childs_years, :childs_months)
  end
end
