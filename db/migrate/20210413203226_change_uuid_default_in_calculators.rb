# frozen_string_literal: true

class ChangeUuidDefaultInCalculators < ActiveRecord::Migration[6.1]
  enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")

  def up
    change_column_default :calculators, :uuid, "gen_random_uuid()"
  end

  def down
    change_column_default :calculators, :uuid, nil
  end
end
