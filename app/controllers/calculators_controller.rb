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
    # renders calculator.html.slim
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
