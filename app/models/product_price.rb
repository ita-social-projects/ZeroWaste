# frozen_string_literal: true

class ProductPrice < ApplicationRecord
  belongs_to :product
  enum category: %i[BUDGETARY MEDIUM PREMIUM]
  validates :category, :price, presence: true
end
