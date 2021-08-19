# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < ApplicationController
      def compute
        @fields = Calculator.find_by(slug: params['id']).fields.result
        render json: @fields, root: 'result', adapter: :json
      end
    end
  end
end
