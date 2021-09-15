# frozen_string_literal: true

module Admins
  class CalculatorsController < ApplicationController
    before_action :find_calculator, except: %i[new create calculator_params]
    layout 'admin'

    def new
      @calculator = Calculator.new
    end

    def create
      @calculator = Calculator.new(calculator_params)
      if @calculator.save
        redirect_to edit_admins_calculator_path(@calculator.id),
                    notice: 'Calculator was successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @calculator.update(calculator_params)
        redirect_to edit_admins_calculator_path(@calculator.id),
                    notice: 'Successfully Updated'
      else
        flash[:error] = 'Invalid'
        render 'edit'
      end
    end

    private

    def find_calculator
      @calculator = Calculator.find(params[:id])
    end

    def calculator_params
      params.require(:calculator).permit(:name, :id)
    end
  end
end
