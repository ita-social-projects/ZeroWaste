# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  from          :integer
#  kind          :integer          not null
#  label         :string
#  name          :string
#  selector      :string           not null
#  to            :integer
#  type          :string           not null
#  unit          :integer          default("day")
#  uuid          :uuid             not null
#  value         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_fields_on_calculator_id  (calculator_id)
#  index_fields_on_uuid           (uuid) UNIQUE
#
class Field < ApplicationRecord
  belongs_to :calculator

  enum kind: { form: 0, parameter: 1, result: 2 }
  enum unit: { day: 0, week: 1, month: 2, year: 3, date: 4, times: 5,
               money: 6, items: 7 }

  validates :type, :kind, :label, presence: true

  before_create :set_selector, if: -> { selector.blank? }

  private

  def set_selector
    index = Field.order(selector: :desc)
                 .find_by(calculator: calculator, kind: kind)
                 &.selector
                 &.gsub(/\D/, "").to_i.next

    self.selector = "#{kind&.first&.upcase}#{index}"
  end
end
