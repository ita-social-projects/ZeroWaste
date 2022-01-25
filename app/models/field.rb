# frozen_string_literal: true

class Field < ApplicationRecord
  belongs_to :calculator

  enum kind: { form: 0, parameter: 1, result: 2 }
  enum unit: { day: 0, week: 1, month: 2, year: 3, date: 4, times: 5, money: 6 , items: 7 }

  validates :type, :kind, :label, presence: true

  before_create :set_selector, if: -> { selector.blank? }

  private

  def set_selector
    previous_field = Field.order(selector: :desc).find_by(kind: kind)

    self.selector = previous_field&.selector&.succ || "#{kind&.first&.upcase}1"
  end
end
