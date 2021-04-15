# frozen_string_literal: true

class ChangeUuidDefaultInProducts < ActiveRecord::Migration[6.1]
  enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  def change
    change_column :products, :uuid, :uuid, default: 'gen_random_uuid()'
  end
end
