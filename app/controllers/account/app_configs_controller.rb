# frozen_string_literal: true

class Account::AppConfigsController < Account::BaseController
  before_action :app_config
  load_and_authorize_resource

  def update
    update_diapers_calculator
  end

  private

  def app_config
    @app_config = AppConfig.instance
  end

  def diapers_calculator_params
    params.permit([
      :first_amount, :first_price, :second_amount, :second_price, :third_amount,
      :third_price, :fourth_amount, :fourth_price, :fifth_amount, :fifth_price,
      :sixth_amount, :sixth_price, :seventh_amount, :seventh_price
    ])
  end

  def update_diapers_calculator
    @app_config.diapers_calculator = Calculators::DiapersService.diapers_calculator(params)
    @app_config.save
  end
end
