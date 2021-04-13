class Field < ApplicationRecord
  belongs_to :calculator
  before_save :set_uuid, :set_selector
  validates :uuid, :type, :selector, :label, :kind, presence: true
  enum kind: { form: 0, parameter: 1, result: 2 }

  private
    def set_uuid
      self.uuid = SecureRandom.uuid if self.uuid.nil?
    end
    
    def set_selector
      if self.selector.nil?
        selected_rows_count = Field.where(type: :kind).count
        if selected_rows_count.positive?
          previous_number = Field.where(type: :kind).last[1]
          self.selector = self.type[0].upcase + previous_number.next.to_s
        else
          self.selector = self.type[0].upcase + "1"
        end
      end
    end  
end
