class ProductPrice < ApplicationRecord
  belongs_to :product
  enum category: [:LOW, :MIDDLE, :HIGH]
end
