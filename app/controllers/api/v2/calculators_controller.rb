# frozen_string_literal: true

class Api::V2::CalculatorsController < ApplicationController
  def compute
    @fields = Calculator.find_by(slug: params["id"]).fields.result

    render json: @fields, root: "result", adapter: :json
  end
end
