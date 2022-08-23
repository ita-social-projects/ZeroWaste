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
        result = diapers_service_handler(childs_age, product_price).calculate!
        diapers = diapers_correct_form(result.to_be_used_diapers_amount)
        VALUES[0][:result] = result.used_diapers_price
        VALUES[1][:result] = result.to_be_used_diapers_price
        VALUES[2][:result] = result.used_diapers_amount
        VALUES[3][:result] = result.to_be_used_diapers_amount
        render(json: { result: VALUES, date: childs_age,
                       word_form: diapers })
      end

      private

      def diapers_correct_form(quantity)
        LanguageHelper::UkrLanguage.new.correct_word_form(quantity)
      end

      def diapers_service_handler(age, price_category)
        @diapers_service_handler ||=
          Calculators::DiapersService.new(age, price_category)
      end

      def childs_age
        params[:childs_age].to_i
      end

      def product_price
        ProductPrice.find_by_id(params[:price])
      end
    end
  end
end
