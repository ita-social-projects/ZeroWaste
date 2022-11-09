# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  uuid            :uuid             not null
#  title           :string
#  product_type_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Product < ApplicationRecord
  belongs_to :product_type

  validates :title, presence: true, length: { in: 2..50 }
end
