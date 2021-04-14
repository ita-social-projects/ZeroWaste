class Select < Field
  belongs_to :fields
  validates :value, presence: true
  validates :value, length: { minimum: 2 }
end
