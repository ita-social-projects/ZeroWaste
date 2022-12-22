# frozen_string_literal: true

class Api::V1::DiaperCalculatorsController < ApplicationController
  def calculate
    if !(params[:childs_years].nil? || params[:childs_months].nil?)
      childs_age = params[:childs_years] + params[:childs_months]
      result          = Calculators::DiapersService.new(childs_age).calculate!
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
          date: params[:childs_age].to_i,
          word_form_to_be_used: diapers_be_used,
          word_form_used: diapers_used
        }, status: 200
      )
    else
      render(
        json:{
          errors: check_data_present()
        }, status: 422
      )
    end
  end

  private

  def check_data_present()
    errors = []
    if params[:childs_years].nil? && params[:childs_months].nil?
      errors << t('calculators.calculator.year_and_month_error_msg')
    elsif params[:childs_years].nil?
      errors << t('calculators.calculator.year_error_msg')
    elsif params[:childs_months].nil?
      errors << t('calculators.calculator.month_error_msg')
    end

    errors
  end

end
