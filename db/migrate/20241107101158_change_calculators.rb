class ChangeCalculators < ActiveRecord::Migration[7.2]
  def change
    remove_columns :calculators, :uuid, :name, :preferable

    add_column :calculators, :uk_name, :string, null: false, default: ""
    add_column :calculators, :en_name, :string, null: false, default: ""
  end
end
