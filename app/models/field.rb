# frozen_string_literal: true

# == Schema Information
#
# Table name: fields
#
#  id            :bigint           not null, primary key
#  uuid          :uuid             not null
#  calculator_id :bigint           not null
#  selector      :string           not null
#  type          :string           not null
#  label         :string
#  name          :string
#  value         :string
#  from          :integer
#  to            :integer
#  kind          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  unit          :integer          default("day")
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
                 &.gsub(/\D/, '').to_i.next

    self.selector = "#{kind&.first&.upcase}#{index}"
  end
end
