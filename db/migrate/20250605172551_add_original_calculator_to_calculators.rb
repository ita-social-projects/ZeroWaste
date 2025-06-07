class AddOriginalCalculatorToCalculators < ActiveRecord::Migration[7.2]
  def change
    add_reference :calculators, :original_calculator, foreign_key: { to_table: :calculators }
  end
end
