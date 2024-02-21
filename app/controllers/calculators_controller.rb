# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :authenticate_user!, only: :receive_recomendations

  def index
    if Flipper[:show_calculators_list].enabled?
      @calculators = collection
    else
      head :not_found
    end
  end

  def show
    @calculator = resource
  end

  def calculate
    @calculator = resource
  end

  def calculator
    @diaper_categories   = DiapersPeriod.ordered_categories
    @preferable_category = Category.find_by(preferable: :preferable)

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
