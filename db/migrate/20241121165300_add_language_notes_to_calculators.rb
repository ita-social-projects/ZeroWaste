class AddLanguageNotesToCalculators < ActiveRecord::Migration[7.2]
  def change
    change_table :calculators, bulk: true do |t|
      t.text :uk_notes
      t.text :en_notes
    end
  end
end
