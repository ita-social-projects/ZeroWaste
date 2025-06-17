# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  kind          :string           not null
#  uk_label      :string           default(""), not null
#  unit          :integer          default("day")
#  var_name      :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
class Field < ApplicationRecord
  include Translatable

  translates :label

  belongs_to :calculator

  has_many :categories, dependent: :destroy
  has_many :select_options, dependent: :destroy

  NUMBER   = "number"
  CATEGORY = "category"
  SELECT_OPTION = "select_option"
  KINDS    = { number: NUMBER, category: CATEGORY, select_option: SELECT_OPTION }.freeze

  enum :kind, KINDS
  enum :unit, { day: 0, week: 1, month: 2, year: 3, date: 4, times: 5, money: 6, items: 7 }

  validates :kind, presence: true
  validates :uk_label, :en_label, presence: true, length: { minimum: 3, maximum: 50 }
  validates :var_name, presence: true, format: { with: /\A[a-zA-Z_]+\z/ }

  validates_with FieldValidator

  accepts_nested_attributes_for :categories, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :select_options, reject_if: :all_blank, allow_destroy: true
end
