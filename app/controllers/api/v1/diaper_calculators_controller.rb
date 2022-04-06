# frozen_string_literal: true

module Api
  module V1
    class DiaperCalculatorsController < ApplicationController
      VALUES = [
        { name: 'money_spent', result: 7841 },
        { name: 'money_will_be_spent', result: 342 }
      ].freeze

      def create
        result = diapers_service_handler(childs_birthday).calculate!
        VALUES.first[:result] = result.used_diapers_price
        VALUES.last[:result] = result.to_be_used_diapers_price
        render(json: { result: VALUES, date: childs_birthday })
      end

      private

      def diapers_service_handler(age)
        @diapers_service_handler ||= Calculators::DiapersService.new(age)
      end

      def childs_birthday
        params[:childs_birthday]
      end
    end
  end
end
