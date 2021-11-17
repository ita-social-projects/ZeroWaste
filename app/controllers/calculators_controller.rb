# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def index
    @calculators = Calculator.friendly.all
  end

  def show
    @calculator = Calculator.friendly.find(params[:id])
  end
end