# frozen_string_literal: true

module Api
  module V1
    class CalculatorsController < ApplicationController
      VALUES = {bought_diapers:8956,money_spent:7841,garbage_created:342}
      def compute
        render json:VALUES
      end
    end
  end
end
