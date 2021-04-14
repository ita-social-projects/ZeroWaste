class NamedValue < Field
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
end
