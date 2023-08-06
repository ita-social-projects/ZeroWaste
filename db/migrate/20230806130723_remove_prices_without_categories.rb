class RemovePricesWithoutCategories < ActiveRecord::Migration[6.1]
  def change
    categories = Category.pluck(:id)

    Price.all.each do |price|
      price.destroy unless categories.include?(price.category_id)
    end
  end
end
