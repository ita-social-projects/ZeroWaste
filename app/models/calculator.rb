class Calculator < ApplicationRecord
  has_many :fields
  before_validation :set_uuid
  validates :name, :presence => true
  validates :name, :format => { :with => /\A[a-zA-Z]+\z/,
  :message => "Only letters allowed" }
  validates :name, :length => { :minimum => 2 }
  private
  def set_uuid
    self.uuid = SecureRandom.uuid if self.uuid.nil?
  end
end
