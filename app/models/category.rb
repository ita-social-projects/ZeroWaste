# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_categoryables, dependent: :restrict_with_exception
  has_many :categoryables, through: :category_categoryables

  has_one :price

  validates :name, presence: true

  scope :ordered_by_name, -> { order(:name) }
end
