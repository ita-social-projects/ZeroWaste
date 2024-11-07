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
  has_many :fields, dependent: :destroy
  has_many :formulas, dependent: :destroy

  accepts_nested_attributes_for :fields, allow_destroy: true
end
