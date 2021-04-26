class AddSlugToCalculators < ActiveRecord::Migration[6.1]
  def change
    add_column :calculators, :slug, :string
    add_index :calculators, :slug, unique: true
  end
end
