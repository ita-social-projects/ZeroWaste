# frozen_string_literal: true

# == Schema Information
#
# Table name: product_types
#
#  id         :bigint           not null, primary key
#  uuid       :uuid             not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProductType < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :title, format: { with: /[a-zA-Z0-9]/ }
end
