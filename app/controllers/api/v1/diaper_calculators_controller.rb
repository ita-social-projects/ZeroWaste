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

      DIAPER_TITLE = 'diaper'

      MEDIUM = 'MEDIUM'

      def create
        result = diapers_service_handler(childs_age).calculate!
        diapers_be_used = diapers_correct_form(result.to_be_used_diapers_amount)
        diapers_used = diapers_correct_form(result.used_diapers_amount)
        VALUES[0][:result] = result.used_diapers_price
        VALUES[1][:result] = result.to_be_used_diapers_price
        VALUES[2][:result] = result.used_diapers_amount
        VALUES[3][:result] = result.to_be_used_diapers_amount
        render(json: { result: VALUES, date: childs_age,
                       word_form_to_be_used: diapers_be_used,
                       word_form_used: diapers_used })
      end

      private

      def diapers_correct_form(quantity)
        LanguageHelper::UkrLanguage.new.correct_word_form(quantity)
      end

      def diapers_service_handler(age)
        @diapers_service_handler ||= Calculators::DiapersService.new(age)
      end

      def childs_age
        params[:childs_age].to_i
      end

      def diaper
        @diaper ||= Product.find_by(title: DIAPER_TITLE)
      end

      def default_price
        ProductPrice.find_by(category: MEDIUM, product: diaper)
      end

      def product_price
        selected_price = ProductPrice.find_by(category: params[:price_id],
                                              product: diaper)
        selected_price || default_price
      end
    end
  end
end
