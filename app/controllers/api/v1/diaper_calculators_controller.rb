# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def calculate
    @validation = Calculators::ValidationService.new(params).validate

    if @validation[:is_valid] == true

      result = Calculators::DiapersService.new(params[:childs_years], params[:childs_months]).calculate!

      calculator_decorator = CalculatorDecorator.new(result)

      render json: calculator_decorator.for_json, status: :ok
    else
      render(
        json: {
          error: @validation[:error]
        }, status: :unprocessable_entity
      )
    end
  end
end
