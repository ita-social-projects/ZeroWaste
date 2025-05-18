class CalculatorsSerializerService < ApplicationService
  def initialize(collection)
    @collection = collection
  end

  def call
    @collection.map do |calculator|
      {
        name: calculator.name,
        notes: calculator.notes
      }
    end
  end
end
