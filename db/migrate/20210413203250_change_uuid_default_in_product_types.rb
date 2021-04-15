# frozen_string_literal: true

class ChangeUuidDefaultInProductTypes < ActiveRecord::Migration[6.1]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    change_column :product_types, :uuid, :uuid, default: 'gen_random_uuid()'
  end
end
