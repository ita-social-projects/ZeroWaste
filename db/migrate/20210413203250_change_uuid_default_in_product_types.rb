# frozen_string_literal: true

class ChangeUuidDefaultInProductTypes < ActiveRecord::Migration[6.1]
  enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

  def up
    change_column_default :product_types, :uuid, "gen_random_uuid()"
  end

  def down
    change_column_default :product_types, :uuid, nil
  end
end
