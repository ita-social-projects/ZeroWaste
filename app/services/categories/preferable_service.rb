# frozen_string_literal: true

class Categories::PreferableService
  def initialize(category)
    @category = category
  end

  def call
    if @category.preferable
      Category.where.not(id: @category.id).update(preferable: false)
    end
  end
end
