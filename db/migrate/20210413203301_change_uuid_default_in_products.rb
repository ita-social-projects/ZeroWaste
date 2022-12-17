# frozen_string_literal: true

class ChangeUuidDefaultInProducts < ActiveRecord::Migration[6.1]
  enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

  def up
    change_column_default :products, :uuid, "gen_random_uuid()"
  end

  def down
    change_column_default :products, :uuid, nil
  end
end
