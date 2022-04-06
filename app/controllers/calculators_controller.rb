# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :find_calculator, only: [:show, :calculate]

  def index
    @calculators = Calculator.friendly.all
  end

  def show; end

  def calculate; end

  def calculator;
    # renders calculator.html.slim
  end

  def receive_notifications
    user_with_access?()
  end

  private

  def find_calculator
    @calculator = Calculator.friendly.find(params[:slug])
  end

  def user_with_access?
    current_user.update_attribute(:receive_recomendations, true) if user_signed_in?
  end
end
