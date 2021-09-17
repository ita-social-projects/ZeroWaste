# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < ApplicationController
      def compute
        @fields = Calculator.find_by(slug: params['id']).fields.result
        render json: @fields, root: 'result', adapter: :json
        @fields.each do |field|
          cal_res = CalculatorResolver.call(field.calculator)
          res = cal_res.each_with_object({}) do |(key, value), result|
            result[key[:value]] = value.each_with_object({}) do |v, sel|
              sel[v[:selector].downcase] = v[:value]
            end
          end
          res.each do |key, value|
            CalculationResolver.result(value, key)
          end
        end
      end
    end
  end
end
