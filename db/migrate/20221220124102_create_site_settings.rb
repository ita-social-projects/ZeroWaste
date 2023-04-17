class CreateSiteSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :site_settings do |t|
      t.string :title, default: "ZeroWaste", null: false

      t.timestamps
    end
  end
end
