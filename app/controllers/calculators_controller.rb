# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :validate_birthday_date

  def index
    @calculators = Calculator.friendly.all
  end

  def show
    @calculator = Calculator.friendly.find(params[:id])
  end

  def validate_birthday_date
    return unless params[:birthday]

    raise ArgumentError if Date.parse(params[:birthday]).future?
  rescue ArgumentError
    redirect_to calculator_path(params[:id])
  end

end
