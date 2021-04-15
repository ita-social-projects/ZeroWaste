class Field < ApplicationRecord
  belongs_to :calculator
  before_create :set_selector
  validates :type, :label, :kind, presence: true
  enum kind: { form: 0, parameter: 1, result: 2 }

  private
    def set_selector
      return if self.selector.present?
      
      selected_rows_count = Field.where(kind: self.kind).count
      if selected_rows_count.positive?
        previous_number = Field.where(kind: self.kind).last.selector[1]
        self.selector = self.kind[0].upcase + previous_number.next.to_s
      else
        self.selector = self.kind[0].upcase + "1"
      end
    end
end
