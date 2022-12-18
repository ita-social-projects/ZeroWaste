class FixCalculatorCreation < ActiveRecord::Migration[6.1]
  def up
    Calculator.create(name: "Diapers Calculator")
  end

  def down
    Calculator.destroy_by(name: "Diapers Calculator")
  end
end
