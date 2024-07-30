# frozen_string_literal: true

# == Schema Information
#
# Table name: prices
#
#  id             :bigint           not null, primary key
#  priceable_type :string
#  sum            :decimal(8, 2)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer
#  priceable_id   :bigint
#
# Indexes
#
#  index_prices_on_category_id                                      (category_id)
#  index_prices_on_category_id_and_priceable_id_and_priceable_type  (category_id,priceable_id,priceable_type) UNIQUE
#  index_prices_on_priceable                                        (priceable_type,priceable_id)
#
class Price < ApplicationRecord
  belongs_to :priceable, polymorphic: true
  belongs_to :category, optional: true

  validates :sum, presence: true
  validates :sum, numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000 }
  validates :category_id, uniqueness: { scope: [:priceable_id, :priceable_type] }
end
