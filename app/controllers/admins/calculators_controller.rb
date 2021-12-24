# frozen_string_literal: true

module Admins
  class CalculatorsController < BaseController
    before_action :calculator, only: %i[show edit update destroy]

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
        redirect_to admins_calculators_path,
                    notice: 'Calculator has been successfully created.'
      else
        render action: 'new'
      end
    end

    def update
      if @calculator.update(calculator_params)
        redirect_to admins_calculators_path,
                    notice: 'Calculator has been successfully updated.'
      else
        render action: 'edit'
      end
    end

    def destroy
      @calculator.destroy!
      redirect_to admins_calculators_path,
                  notice: 'Calculator has been successfully deleted.'
    end

    private

    def calculator
      @calculator = Calculator.friendly.find(params[:id])
    end

    def calculator_params
      params.require(:calculator).permit(:name, :id, :slug)
    end
  end
end
