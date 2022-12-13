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

  belongs_to :product_type

  validates :title, presence: true, length: { in: 2..50 }

  def self.diaper
    find_by(title: DIAPER)
  end
end
