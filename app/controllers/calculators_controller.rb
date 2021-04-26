# frozen_string_literal: true

class CalculatorsController < ApplicationController
  def show
    @calculator = Calculator.friendly.find(params[:id])
  end
end
