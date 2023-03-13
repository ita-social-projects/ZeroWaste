# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :priceable, polymorphic: true
  belongs_to :category, optional: true

  accepts_nested_attributes_for :category

  validates :sum, presence: true
  validates :category_id, uniqueness: { scope: [:priceable_id, :priceable_type] }
end
