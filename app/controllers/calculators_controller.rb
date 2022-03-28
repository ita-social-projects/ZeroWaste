# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def index
    @calculators = Calculator.friendly.all
  end

  def show
    @calculator = Calculator.friendly.find(params[:slug])
  end

#renders calculator page
  def calculator
  end
end