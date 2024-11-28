class AddLanguageNotesToCalculators < ActiveRecord::Migration[7.2]
  def change
    change_table :calculators, bulk: true do |t|
      t.text :ukranian_additional_notes
      t.text :english_additional_notes
    end
  end
end
