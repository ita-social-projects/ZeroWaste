# frozen_string_literal: true

module Api
  module V1
    class DiaperCalculatorsController < ApplicationController
      def create
        result = Calculators::DiapersService.new(params[:childs_age].to_i)
                                            .calculate!
        I18n.locale = params[:locale] || :uk

        diapers_be_used = t('calculators.calculator.diaper').pluralize(
          count: result.to_be_used_diapers_amount,
          locale: I18n.locale
        )

        diapers_used = t('calculators.calculator.diaper').pluralize(
          count: result.used_diapers_amount,
          locale: I18n.locale
        )

        values = [
          { name: 'money_spent', result: result.used_diapers_price || 0 },
          { name: 'money_will_be_spent',
            result: result.to_be_used_diapers_price || 0 },
          { name: 'used_diapers_amount',
            result: result.used_diapers_amount || 0 },
          { name: 'to_be_used_diapers_amount',
            result: result.to_be_used_diapers_amount || 0 }
        ]
        render(json: { result: values, date: params[:childs_age].to_i,
                       word_form_to_be_used: diapers_be_used,
                       word_form_used: diapers_used })
      end
    end
  end
end
