# frozen_string_literal: true

# == Schema Information
#
# Table name: calculators
#
#  id         :bigint           not null, primary key
#  en_name    :string           not null
#  slug       :string
#  uk_name    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_calculators_on_slug  (slug) UNIQUE
#

class Calculator < ApplicationRecord
  include Translatable

  translates :name
  
  has_many :fields, dependent: :destroy
  has_many :formulas, dependent: :destroy

  accepts_nested_attributes_for :fields, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :formulas, reject_if: :all_blank, allow_destroy: true

  translates :name

  scope :ordered_by_name, -> { order(:en_name) }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "preferable", "slug", "updated_at", "uuid"]
  end
end
