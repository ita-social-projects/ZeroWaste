# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :find_calculator, only: [:show, :calculate]
  before_action :authenticate_user!, only: :receive_recomendations

  def index
    @calculators = Calculator.friendly.all
  end

  def show
  end

  def calculate
  end

  def calculator
    # renders calculator.html.slim
  end

  def receive_recomendations
    current_user.toggle(:receive_recomendations)

    current_user.save
  end

  private

  def find_calculator
    @calculator = Calculator.friendly.find(params[:slug])
  end
end
