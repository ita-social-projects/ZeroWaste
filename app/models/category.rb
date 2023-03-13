# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_categoryables, dependent: :restrict_with_exception
  has_many :categoryables, through: :category_categoryables

  has_one :price

  scope :ordered_categories, -> { Category.order(:name) }

  validates :name, presence: true
end
