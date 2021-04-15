# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :product_type

  validates :title, presence: true, length: { in: 2..50 }
end
