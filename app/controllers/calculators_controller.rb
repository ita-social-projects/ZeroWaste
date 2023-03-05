# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :find_calculator, only: [:show, :calculate]
  before_action :authenticate_user!, only: :receive_recomendations

  def index
    @calculators = collection
  end

  def show;end

  def calculate;end

  def calculator
    # renders calculator.html.slim
  end

  def receive_recomendations
    current_user.toggle(:receive_recomendations)

    current_user.save
  end

  private

  def find_calculator
    @calculator = resource
  end

  def resource
    Calculator.friendly.find(params[:slug])
  end

  def collection
    Calculator.friendly.all
  end

end
