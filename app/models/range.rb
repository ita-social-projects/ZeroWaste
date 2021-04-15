class Range < Field
  validates :from, :to, :value, presence: true #length: { minimum: 1 }
  #validates :from, :to, numericality: { only_integer: true }
end
