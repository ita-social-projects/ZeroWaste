# frozen_string_literal: true

class ProductType < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :title, format: { with: /[a-zA-Z0-9]/ }
end
