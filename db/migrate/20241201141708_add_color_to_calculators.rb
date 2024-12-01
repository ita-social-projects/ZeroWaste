class AddColorToCalculators < ActiveRecord::Migration[7.2]
  def change
    add_column :calculators, :color, :string, default: "#000000"
  end
end
