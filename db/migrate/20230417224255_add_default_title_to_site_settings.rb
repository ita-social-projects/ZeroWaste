class AddDefaultTitleToSiteSettings < ActiveRecord::Migration[6.1]
  def change
    change_column_default :site_settings, :title, "ZeroWaste"
  end
end
