# frozen_string_literal: true

module Api
  module V1
    class DiaperCalculatorsController < ApplicationController
      VALUES = [
        { name: 'money_spent', result: 0 },
        { name: 'money_will_be_spent', result: 0 },
        { name: 'used_diapers_amount', result: 0 },
        { name: 'to_be_used_diapers_amount', result: 0 }
      ].freeze

      def create
        result = diapers_service_handler(childs_age).calculate!
        VALUES[0][:result] = result.used_diapers_price
        VALUES[1][:result] = result.to_be_used_diapers_price
        VALUES[2][:result] = result.used_diapers_amount
        VALUES[3][:result] = result.to_be_used_diapers_amount
        render(json: { result: VALUES, date: childs_age })
      end

      private

      def diapers_service_handler(age)
        @diapers_service_handler ||= Calculators::DiapersService.new(age)
      end

      def childs_age
        params[:childs_age].to_i
      end
    end
  end
end
