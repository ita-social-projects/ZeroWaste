class NamedValue < Field
  belongs_to :fields
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
end
