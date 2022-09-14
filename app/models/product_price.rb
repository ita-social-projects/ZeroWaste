# frozen_string_literal: true

class ProductPrice < ApplicationRecord
  belongs_to :product
  enum category: {
    BUDGETARY: 'BUDGETARY',
    MEDIUM: 'MEDIUM',
    PREMIUM: 'PREMIUM'
  }
  validates :category, :price, presence: true
end
