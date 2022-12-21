# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def diaper_calc_communicator
    result          = Calculators::DiapersService.new(params[:childs_age]).calculate!
    diapers_be_used = t("calculators.calculator.diaper").pluralize(
      count: result.to_be_used_diapers_amount,
      locale: I18n.locale
    )

    diapers_used = t("calculators.calculator.diaper").pluralize(
      count: result.used_diapers_amount,
      locale: I18n.locale
    )
    values          = {
      money_spent: result.used_diapers_price ,
      money_will_be_spent: result.to_be_used_diapers_price ,
      used_diapers_amount: result.used_diapers_amount ,
      to_be_used_diapers_amount: result.to_be_used_diapers_amount
    }
    render(
      json: {
        result: values,
        date: params[:childs_age].to_i,
        word_form_to_be_used: diapers_be_used,
        word_form_used: diapers_used
      }
    )
  end
end
