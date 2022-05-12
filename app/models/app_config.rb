class AppConfig < ApplicationRecord
  validates_inclusion_of :singleton_guard, :in => [0]
  
  def self.instance
    first_or_create!(singleton_guard: 0)
  end
end