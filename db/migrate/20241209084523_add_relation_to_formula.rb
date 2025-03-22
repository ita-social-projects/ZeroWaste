class AddRelationToFormula < ActiveRecord::Migration[7.2]
  def change
    add_column :formulas, :relation, :string
  end
end
