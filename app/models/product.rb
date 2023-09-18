# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  title           :string
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product_type_id :bigint
#
# Indexes
#
#  index_products_on_product_type_id  (product_type_id)
#  index_products_on_uuid             (uuid) UNIQUE
#
class Product < ApplicationRecord
  DIAPER = "diaper"

  has_many :prices, as: :priceable, dependent: :destroy
  has_many :categories_by_prices, through: :prices, source: :category

  validates :title, presence: true, length: { in: 2..50 }

  accepts_nested_attributes_for :prices, reject_if: :blank_prices, allow_destroy: true

  def self.diaper
    find_by(title: DIAPER)
  end

  def price_by_category(category)
    prices.where(category: category).first
  end

  def build_unsigned_categories
    unsigned_categories = Category.unsigned_categories(self)

    prices.build(unsigned_categories.map { |category| { category: category } })
  end

  private

  def blank_prices(attributes)
    attributes[:sum].blank?
  end
end
