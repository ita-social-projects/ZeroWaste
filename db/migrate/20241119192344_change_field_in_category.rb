class ChangeFieldInCategory < ActiveRecord::Migration[7.2]
  def change
    change_column_null :categories, :field_id, true
  end
end
