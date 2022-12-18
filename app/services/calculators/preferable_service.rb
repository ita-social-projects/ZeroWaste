# frozen_string_literal: true

class Calculators::PreferableService
  def initialize(params)
    @preferable = params.fetch(:preferable, nil)
    @slug       = params.fetch(:slug, nil)
  end

  def perform!
    return unless @preferable.to_i == 1

    Calculator.where.not(slug: @slug).each do |calc|
      calc.update(preferable: false)
    end
  end
end
