class Calculator < ApplicationRecord
  has_many :fields
  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z]+\z/,
  message: "Only letters allowed" }
  validates :name, length: { minimum: 2 }
end
