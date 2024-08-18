# frozen_string_literal: true

class CalculatorForm
  include ActiveModel::Model

  attr_accessor :period, :product_category, :price_id

  validates :period, presence: true
  validates :price_id, presence: true
end
