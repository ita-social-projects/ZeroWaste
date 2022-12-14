# frozen_string_literal: true

class Price < ApplicationRecord
  belongs_to :priceable, polymorphic: true
  belongs_to :category, optional: true

  validates :sum, presence: true
  validates :priceable_id, uniqueness: { scope: [:category_id] }
end
