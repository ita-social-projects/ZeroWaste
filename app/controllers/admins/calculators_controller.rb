# frozen_string_literal: true

module Admins
  class CalculatorsController < ApplicationController
    layout 'admin'

    def index
      @calculators = Calculator.friendly.all
    end

    def show
      @calculator = Calculator.friendly.find(params[:id])
    end
  end
end
