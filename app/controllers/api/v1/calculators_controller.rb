# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < ApplicationController
      def compute
        render json: {}
      end
    end
  end
end
