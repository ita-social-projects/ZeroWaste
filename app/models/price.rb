class Price < ApplicationRecord
  belongs_to :priceable, polymorphic: true
  belongs_to :category, optional: true

  validates :price, presence: true
  # потрібно переписати валідацію на старішу версію
  # validates :priceable, uniqueness: { scope: :category_id }
end
