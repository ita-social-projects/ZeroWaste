# frozen_string_literal: true

class CalculatorsController < ApplicationController
  before_action :authenticate_user!, only: :receive_recomendations

  before_action :check_constructor_flipper, only: [:index, :show, :calculate]
  before_action :check_mhc_flipper, only: :mhc_calculator

  def index
    if Flipper[:show_calculators_list].enabled?
      @q           = collection.ransack(params[:q])
      @calculators = @q.result
    else
      head :not_found
    end
  end

  def show
    @calculator = resource
    add_breadcrumb t("breadcrumbs.home"), root_path
    add_breadcrumb @calculator.name
  end

  def calculate
    @calculator = resource
    load_images if @images.nil?

    @results = Calculators::CalculationService.new(@calculator, params[:inputs]).perform

    session[:calculation_results]                 ||= {}
    session[:calculation_results][@calculator.slug] = @results

    @results.each_with_index do |result, index|
      result[:formula_image] = @images[index][:formula_image]
    end

    respond_to :turbo_stream
  end

  def calculator
    @diaper_categories   = Category.ordered_by_diapers_periods_price
    @preferable_category = Category.preferable.first
    add_breadcrumb t("breadcrumbs.home"), root_path
    add_breadcrumb t(".new_calculator.diaper_сalculator")

    if Flipper[:new_calculator_design].enabled?
      render "calculators/new_calculator"
    else
      render "calculators/old_calculator"
    end
  end

  def mhc_calculator
    add_breadcrumb t("breadcrumbs.home"), root_path
    add_breadcrumb t(".mhc_calculator.calculator_name")
  end

  def receive_recomendations
    current_user.toggle(:receive_recomendations)
    current_user.save
  end

  private

  def collection
    Calculator.ordered_by_name
  end

  def resource
    collection.friendly.find(params[:slug])
  end

  def check_constructor_flipper
    return if Flipper[:constructor_status].enabled?

    raise ActionController::RoutingError, "Constructor flipper is disabled"
  end

  def check_mhc_flipper
    return if Flipper[:mhc_calculator_status].enabled?

    raise ActionController::RoutingError, "Mhc calculator flipper is disabled"
  end

  def load_images
    @images = @calculator.formulas.map do |formula|
      if formula.formula_image.attached?
        {
          id: formula.id,
          formula_image: rails_blob_path(formula.formula_image)
        }
      else
        { id: formula.id, formula_image: "/assets/money_spent.png" }
      end
    end
  end
end
