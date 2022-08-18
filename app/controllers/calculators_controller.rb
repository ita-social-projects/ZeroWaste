# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :find_calculator, only: %i[show calculate]

  def index
    @calculators = Calculator.friendly.all
  end

  def show; end

  def calculate; end

  def calculator
    # renders calculator.html.slim
  end

  def receive_recomendations
    return unless user_signed_in?

    current_user.update_attribute(:receive_recomendations,
                                  true)
  end

  private

  def find_calculator
    @calculator = Calculator.friendly.find(params[:slug])
  end

  def product_price
    @product_price = ProductPrice.find_by_id(params[:price])
  end
end
