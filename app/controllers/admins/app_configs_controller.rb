# frozen_string_literal: true

module Admins
class AppConfigsController < BaseController
  before_action :config
  load_and_authorize_resource
  
  def update
    
  end

  private


  def config
    @config = AppConfig.instance
  end

  def diapers_calculator_params
    params.permit(
      '1..3' => %i[amount price],
      '4..6' => %i[amount price],
      '7..9' => %i[amount price],
      '10..12' => %i[amount price],
      '13..18' => %i[amount price],
      '19..24' => %i[amount price],
      '25..30' => %i[amount price],
    )
  end
end
end