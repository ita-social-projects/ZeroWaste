class ChangeProducts < ActiveRecord::Migration[6.1]
  def up
    ProductType.find_by(title: 'Diapers').products.create([{title: 'Diapers'}, {title: 'Reusable diapers'}])
  end

  def down
    ProductType.find_by(title: 'Diapers').products.destroy_all
  end
end
