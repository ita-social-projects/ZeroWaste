# frozen_string_literal: true

class Calculator < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :fields
  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/,
                             message: 'Only letters and numbers allowed' }
  validates :name, length: { minimum: 2 }
  validates :name, uniqueness: true
end
