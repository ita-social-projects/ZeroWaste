# frozen_string_literal: true

module Admins
  class CalculatorsController < ApplicationController
    before_action :calculator, only: %i[show edit update]
    layout 'admin'

    def index
      @calculators = if params[:search]
        Calculator.where('name LIKE ?', "%#{params[:search]}%")
      else
        Calculator.friendly.all
      end
    end

    def show
      # TODO: feel it
    end

    def edit
      # TODO: feel it
    end

    def new
      @calculator = Calculator.new
    end

    def create
      @calculator = Calculator.new(calculator_params)
      if @calculator.save
        redirect_to edit_admins_calculator_path(@calculator.id),
                    notice: 'Calculator has been successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @calculator.update(calculator_params)
        redirect_to edit_admins_calculator_path(@calculator.id),
                    notice: 'Calculator has been successfully updated.'
      else
        render action: 'edit'
      end
    end

    private

    def calculator
      @calculator = Calculator.friendly.find(params[:id])
    end

    def calculator_params
      params.require(:calculator).permit(:name, :id)
    end
  end
end
