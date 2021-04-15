class Select < Field
  validates :value, presence: true
  validates :value, length: { minimum: 2 }
end
