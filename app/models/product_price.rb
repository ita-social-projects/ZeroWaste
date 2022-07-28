class ProductPrice < ApplicationRecord
  belongs_to :product
  enum category: {
    LOW: 0,
    MEDIUM: 1,
    HIGH: 2,
  }
end
