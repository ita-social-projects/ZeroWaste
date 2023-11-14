# frozen_string_literal: true

class AddUuidcheckingToProducts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :products, :uuid, false
  end
end
