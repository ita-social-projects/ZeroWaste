# frozen_string_literal: true

module Admins
  class CalculatorsController < ApplicationController
    layout 'admin'

    def index
      if params[:search]
        @calculators = Calculator.where('name LIKE ?', "%#{params[:search]}%")
      else
        @calculators = Calculator.friendly.all
      end
    end

    def show
      @calculator = Calculator.friendly.find(params[:id])
    end
  end
end
