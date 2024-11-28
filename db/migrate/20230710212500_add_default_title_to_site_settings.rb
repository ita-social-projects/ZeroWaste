class AddDefaultTitleToSiteSettings < ActiveRecord::Migration[7.1]
  def up
    change_column_default :site_settings, :title, from: nil, to: "ZeroWaste"
    change_table :site_settings, bulk: true do |t|
      t.change_null :title, false
    end
  end

  def down
    change_column_default :site_settings, :title, from: "ZeroWaste", to: nil
    change_table :site_settings, bulk: true do |t|
      t.change_null :title, true
    end
  end
end
