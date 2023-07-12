# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :authenticate_user!, only: :receive_recomendations

  # def index
  #   @calculators = collection
  # end

  def show
    @calculator = resource
  end

  def calculate
    @calculator = resource
  end

  def calculator
    if Flipper[:new_calculator_design].enabled?
      render "calculators/new_calculator"
    else
      render "calculators/old_calculator"
    end
  end

  def receive_recomendations
    current_user.toggle(:receive_recomendations)
    current_user.save
  end

  private

  def collection
    Calculator.all
  end

  def resource
    collection.friendly.find(params[:slug])
  end
end
