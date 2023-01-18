# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def calculate
    @validation = Calculators::ValidationService.new(params).validate

    if @validation[:is_valid]
      result          = Calculators::DiapersService.new(params[:childs_years], params[:childs_months]).calculate!
      diapers_be_used = t("calculators.calculator.diaper").pluralize(
        count: result.to_be_used_diapers_amount,
        locale: I18n.locale
      )

      diapers_used = t("calculators.calculator.diaper").pluralize(
        count: result.used_diapers_amount,
        locale: I18n.locale
      )
      values       = {
        money_spent: result.used_diapers_price,
        money_will_be_spent: result.to_be_used_diapers_price,
        used_diapers_amount: result.used_diapers_amount,
        to_be_used_diapers_amount: result.to_be_used_diapers_amount
      }
      render(
        json: {
          result: values,
          date: (params[:childs_years].to_i * 12) + params[:childs_months].to_i,
          word_form_to_be_used: diapers_be_used,
          word_form_used: diapers_used
        }, status: :ok
      )
    else
      render(
        json: {
          error: @validation[:error]
        }, status: :unprocessable_entity
      )
    end
  end
end
