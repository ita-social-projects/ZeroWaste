# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < ApplicationController
      VALUES = [
        { name: 'bought_diapers', result: 8956 },
        { name: 'money_spent', result: 7841 },
        { name: 'garbage_created', result: 342 }
      ].freeze

      def compute
        render json: { result: VALUES }
      end
    end
  end
end
