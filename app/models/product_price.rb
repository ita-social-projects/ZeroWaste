# frozen_string_literal: true

class ProductPrice < ApplicationRecord
  belongs_to :product
  validates :category, inclusion: { in: %w[BUDGETARY MEDIUM PREMIUM],
                                    message: '%<value>s not a valid category' }
  validates :category, :price, presence: true
end
