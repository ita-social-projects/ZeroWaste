# frozen_string_literal: true

class ChangeUuidDefaultInFields < ActiveRecord::Migration[7.1]
  enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

  def up
    change_column_default :fields, :uuid, "gen_random_uuid()"
  end

  def down
    change_column_default :fields, :uuid, nil
  end
end
