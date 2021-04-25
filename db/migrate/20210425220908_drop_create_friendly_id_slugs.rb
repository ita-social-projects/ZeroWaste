class DropCreateFriendlyIdSlugs < ActiveRecord::Migration[6.1]
  def change
    drop_table :friendly_id_slugs
  end
end
