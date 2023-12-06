# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end
  def about_us
    respond_to do |format|
      format.html { render :about_us }
    end
  end
end
