class ProductPrice < ApplicationRecord
  enum category: [:LOW, :MEDIUM, :HIGH]
end
