class AddDefaultTitleToSiteSettings < ActiveRecord::Migration[6.1]
  def change
    change_column :site_settings, :title, :string, null: false, default: "ZeroWaste"
  end
end
