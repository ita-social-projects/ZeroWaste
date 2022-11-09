# frozen_string_literal: true

# == Schema Information
#
# Table name: product_prices
#
#  id         :bigint           not null, primary key
#  uuid       :uuid             not null
#  product_id :bigint           not null
#  price      :float
#  category   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProductPrice < ApplicationRecord
  belongs_to :product
  enum category: {
    LOW: 0,
    MEDIUM: 1,
    HIGH: 2
  }
  validates :category, :price, presence: true
end
