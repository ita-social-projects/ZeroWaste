class AddDefaultTitleToSiteSettings < ActiveRecord::Migration[6.1]
  def up
    change_column_default :site_settings, :title, from: nil, to: "ZeroWaste"
    change_column_null :site_settings, :title, false
  end

  def down
    change_column_default :site_settings, :title, from: "ZeroWaste", to: nil
    change_column_null :site_settings, :title, true
  end
end
