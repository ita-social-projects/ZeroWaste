class CategoryCategoryable < ApplicationRecord
  belongs_to :categoryable, polymorphic: true
  belongs_to :category

  validates :categoryable_id, uniqueness: { scope: [:categoryable_type, :category_id] }
end
