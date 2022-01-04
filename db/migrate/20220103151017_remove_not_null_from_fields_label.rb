# frozen_string_literal: true

class RemoveNotNullFromFieldsLabel < ActiveRecord::Migration[6.1]
  def change
    change_column_null :fields, :label, true
  end
end
