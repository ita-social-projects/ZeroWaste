class AddDefaultTitleToSiteSettings < ActiveRecord::Migration[7.1]
  def up
    change_table :site_settings, bulk: true do |t|
      t.change_default :title, from: nil, to: "ZeroWaste"
      t.change_null :title, false
    end
  end

  def down
    change_table :site_settings, bulk: true do |t|
      t.change_default :title, from: "ZeroWaste", to: nil
      t.change_null :title, true
    end
  end
end
