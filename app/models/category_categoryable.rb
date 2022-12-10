class CategoryCategoryable < ApplicationRecord
  belongs_to :categoryable, polymorphic: true
  belongs_to :category

  validate :categoryable, uniqueness: { scope: :category }
end
