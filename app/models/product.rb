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

  scope :ordered_by_title, -> { order(:title) }

  has_many :prices, as: :priceable, dependent: :destroy
  has_many :categories_by_prices, through: :prices, source: :category

  validates :title, presence: true
  validates :title,
            length: { in: 2..30 },
            uniqueness: true,
            format: { with: /\A[a-zA-Zа-яієїґ'А-ЯІЄЇҐ0-9\-\s]+\z/ },
            if: -> { title.present? }

  accepts_nested_attributes_for :prices, reject_if: :blank_prices, allow_destroy: true

  def self.diaper
    find_by(title: DIAPER)
  end

  def price_by_category(category)
    prices.where(category: category).first
  end

  def find_or_build_price_for_category(category)
    prices.find { |p| p.category_id == category.id } || prices.build(category: category)
  end

  def build_unsigned_categories
    unsigned_categories = Category.unsigned_categories(self)

    prices.build(unsigned_categories.map { |category| { category: category } })
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "product_type_id", "title", "updated_at", "uuid"]
  end

  private

  def blank_prices(attributes)
    attributes[:sum].blank?
  end
end
