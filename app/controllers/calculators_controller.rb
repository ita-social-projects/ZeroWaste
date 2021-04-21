class CalculatorsController < ApplicationController

  def show
    render "#{params[:id]}"
  end

end
