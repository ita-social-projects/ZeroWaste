class CategoryValidator
  attr_reader :category, :prices

  def initialize(category)
    @category = category
    @prices = Price.where(category_id: category.id)
  end

  def valid?
    prices.blank?
  end

  def references
    products = []

    prices.each do |price|
      products << Product.where(id: price.priceable_id).pluck(:title)
    end

    products.join(", ")
  end
end
