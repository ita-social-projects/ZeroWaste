# frozen_string_literal: true

class Field < ApplicationRecord
  belongs_to :calculator

  enum kind: { form: 0, parameter: 1, result: 2 }
  enum unit: { day: 0, week: 1, month: 2, year: 3, date: 4, times: 5, money: 6 , items: 7 }

  validates :type, :kind, presence: true

  with_options if: :persisted? do
    validates :label, presence: true
  end

  before_create :set_selector

  private

  def set_selector
    return if selector.present?

    selected_rows_count = Field.where(kind: kind).count
    if selected_rows_count.positive?
      previous_number = Field.where(kind: kind).last.selector[1]
      self.selector = kind[0].upcase + previous_number.next.to_s
    else
      self.selector = "#{kind[0].upcase}1"
    end
  end
end
