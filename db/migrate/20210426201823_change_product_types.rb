class ChangeProductTypes < ActiveRecord::Migration[7.1]
  def up
    ProductType.create(title: "Diapers")
    ProductType.create(title: "Menstrual hygiene")
  end

  def down
    create_table :prices do |t|
      t.references :priceable, polymorphic: true
      t.timestamps
    end

    ProductType.destroy_by(title: "Diapers")
    ProductType.destroy_by(title: "Menstrual hygiene")

    drop_table :prices
  end
end
