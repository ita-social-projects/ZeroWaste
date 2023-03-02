# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_categoryables, dependent: :restrict_with_exception
  has_many :categoryables, through: :category_categoryables

  validates :name, presence: true
  validates :priority, numericality: { greater_than_or_equal_to: 0 }

  scope :ordered_by_priority, -> { order(:priority) }
end
