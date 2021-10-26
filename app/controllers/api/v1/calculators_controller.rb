# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < ApplicationController
      VALUES = [
        { name: 'first_result', result: 20 },
        { name: 'second_result', result: 70 },
        { name: 'third_result', result: 30 }
      ].freeze

      def compute
        render json: { result: VALUES }
      end
    end
  end
end
