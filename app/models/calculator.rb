# frozen_string_literal: true

class Calculator < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :fields
  validates :name, presence: true
  validates :name, format: { with: /[a-zA-Z]+/,
                             message: 'Only letters allowed' }
  validates :name, length: { minimum: 2 }
end
