class AddIndexToProduct < ActiveRecord::Migration[6.1]
  def up
    duplicated_titles = Product
      .select(:title)
      .group(:title)
      .having('count(title) > 1')
      .pluck(:title)

    duplicated_titles.each do |dup_title|
      products = Product.where(title: dup_title)
      products.map { |product| product.update(title: "#{product.title}_#{product.uuid}")}
    end

    add_index :products, :title, unique: true
  end

  def down
    remove_index :products, :title
  end
end
