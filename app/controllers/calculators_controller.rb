# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def show; end

  private

  def set_calculator
    @calculator = Calculator.friendly.find(params[:id])
  end
end
