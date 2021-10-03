# frozen_string_literal: true

module Admins
  class CalculatorsController < ApplicationController
    layout 'admin'

    def index
      @calculators = if params[:search]
                       Calculator.where('name LIKE ?', "%#{params[:search]}%")
                     else
                       Calculator.friendly.all
                     end
    end

    def show
      @calculator = Calculator.friendly.find(params[:id])
    end
  end
end
