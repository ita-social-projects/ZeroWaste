class Field < ApplicationRecord
  belongs_to :calculator
  before_validation :set_uuid, :set_selector
  validates :uuid, :type, :label, :kind, presence: true
  enum kind: { form: 0, parameter: 1, result: 2 }

  private
    def set_uuid
      self.uuid = SecureRandom.uuid if self.uuid.nil?
    end
    
    def set_selector
      existed_selectors_count = Field.where(type: :kind).count
      new_selectors_count = existed_selectors_count.next.to_s
      self.selector = self.type[0].upcase + new_selectors_count
    end  
end
