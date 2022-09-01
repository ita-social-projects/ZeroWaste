# frozen_string_literal: true

module Admins
  class AppConfigsController < BaseController
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
      params.permit(%i[first_amount first_price second_amount second_price
                       third_amount third_price fourth_amount fourth_price
                       fifth_amount fifth_price sixth_amount sixth_price
                       seventh_amount seventh_price price_category_budgetary price_category_medium
                       price_category_premium])
    end

    def update_diapers_calculator
      @app_config.diapers_calculator = {
        (1..3) => {
          amount: params[:first_amount],
          price: params[:first_price]
        },
        (4..6) => {
          amount: params[:second_amount],
          price: params[:second_price]
        },
        (7..9) => {
          amount: params[:third_amount],
          price: params[:third_price]
        },
        (10..12) => {
          amount: params[:fourth_amount],
          price: params[:fourth_price]
        },
        (13..18) => {
          amount: params[:fifth_amount],
          price: params[:fifth_price]
        },
        (19..24) => {
          amount: params[:sixth_amount],
          price: params[:sixth_price]
        },
        (25..30) => {
          amount: params[:seventh_amount],
          price: params[:seventh_price]
        },
        (31..32) => {
          budgetary: params[:price_category_budgetary],
          medium: params[:price_category_medium],
          premium: params[:price_category_premium]
        }
      }
      @app_config.save
    end
  end
end
