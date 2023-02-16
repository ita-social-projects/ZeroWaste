# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def calculate
    @validation = CalculatorValidator.new(params)

    if @validation.valid?

      result = Calculators::DiapersService.new(params[:childs_years], params[:childs_months]).calculate!

      calculator_decorator = CalculatorDecorator.new(result)

      render json: calculator_decorator.to_json, status: :ok
    else
      render(
        json: {
          error: @validation.error
        }, status: :unprocessable_entity
      )
    end
  end
end
