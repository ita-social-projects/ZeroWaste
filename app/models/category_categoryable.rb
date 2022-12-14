class CategoryCategoryable < ApplicationRecord
  belongs_to :categoryable, polymorphic: true
  belongs_to :category

  validates :category_id, uniqueness: { scope: [:categoryable_type, :categoryable_id,] }
end
