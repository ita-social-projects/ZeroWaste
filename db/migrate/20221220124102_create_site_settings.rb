class CreateSiteSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :site_settings do |t|
      t.string :title
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
