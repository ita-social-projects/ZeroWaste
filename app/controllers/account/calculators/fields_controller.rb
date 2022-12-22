# frozen_string_literal: true

class Account::Calculators::FieldsController < Account::BaseController
  def new
    @field      = Field.new(field_params)
    @calculator = Calculator.new(fields: [@field])

    respond_to do |format|
      format.js
    end
  end

  private

  def field_params
    params.require(:field).permit(:kind, :type)
  end
end
