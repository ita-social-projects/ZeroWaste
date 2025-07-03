class AddEnKeyToSelectOptions < ActiveRecord::Migration[7.2]
  def change
    add_column :select_options, :en_key, :string
  end
end
