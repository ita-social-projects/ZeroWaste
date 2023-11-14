# frozen_string_literal: true

class RemoveNotNullFromFieldsLabel < ActiveRecord::Migration[7.1]
  def change
    change_column_null :fields, :label, true
  end
end
