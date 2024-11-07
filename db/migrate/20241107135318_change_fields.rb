class ChangeFields < ActiveRecord::Migration[7.2]
  def change
    remove_columns :fields, :uuid, :selector, :type, :label, :name, :value, :from, :to, :kind, :unit

    add_column :fields, :uk_label, :string, null: false
    add_column :fields, :en_label, :string, null: false
    add_column :fields, :var_name, :string, null: false
    add_column :fields, :field_type, :string, null: false
  end
end
