class ChangeProductTypes < ActiveRecord::Migration[6.1]
  def up
    ProductType.create(title: 'Diapers').products.create([{title: 'Diapers'}, {title: 'Reusable diapers'}])
    ProductType.create(title: 'Menstrual hygiene')
  end

  def down
    ProductType.destroy_by(title: 'Diapers')
    ProductType.destroy_by(title: 'Menstrual hygiene')
  end
end
