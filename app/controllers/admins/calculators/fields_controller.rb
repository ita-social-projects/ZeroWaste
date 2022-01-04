# frozen_string_literal: true

module Admins
  module Calculators
    class FieldsController < ApplicationController
      before_action :calculator, only: :create

      def create
        @field = @calculator.fields.create(field_params)

        if @field.errors.any?
          flash[:alert] = 'Field was not added!'

          return head :unprocessable_entity
        end

        flash[:notice] = 'Field was successfully added!'
        head :ok
      end

      private

      def calculator
        @calculator = Calculator.friendly.find(params[:calculator_slug])
      end

      def field_params
        params.require(:field).permit(:kind, :type)
      end
    end
  end
end