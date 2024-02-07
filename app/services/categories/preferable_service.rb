# frozen_string_literal: true

class Categories::PreferableService
  def initialize(params)
    @preferable = params.fetch(:preferable, nil)
    @id         = params.fetch(:id, nil)
  end

  def perform!
    return unless @preferable.to_i == 1

    Category.where.not(id: @id).each do |cat|
      cat.update(preferable: false)
    end
  end
end
