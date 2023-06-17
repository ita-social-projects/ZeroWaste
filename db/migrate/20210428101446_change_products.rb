class ChangeProducts < ActiveRecord::Migration[6.1]
  def up
    ProductType.find_by(title: "Diapers").products.create([{ title: "Diapers" }, { title: "Reusable diapers" }])
  end

  def down
    create_table :prices do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.references :priceable, polymorphic: true
    end

    products = ProductType.find_by(title: "Diapers")
    products&.destroy_all

    drop_table :prices
  end
end
