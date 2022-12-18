# frozen_string_literal: true

class Admins::Calculators::FieldsController < ApplicationController
  before_action :calculator, only: :new

  def new
    @field      = Field.new(field_params)
    @calculator = Calculator.new(fields: [@field])

    respond_to do |format|
      format.js
    end
  end

  private

  def calculator
    @calculator = Calculator.friendly.find(params[:calculator_slug])
  end

  def field_params
    params.require(:field).permit(:kind, :type)
  end
end
