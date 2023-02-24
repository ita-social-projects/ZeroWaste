# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_categoryables, dependent: :restrict_with_exception
  has_many :categoryables, through: :category_categoryables

  validates :name, presence: true

  scope :ordered_by_priority, -> { order(priority: :asc) }
end
