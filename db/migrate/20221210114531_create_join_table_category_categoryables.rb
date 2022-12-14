class CreateJoinTableCategoryCategoryables < ActiveRecord::Migration[6.1]
  def change
    create_table :category_categoryables do |t|
      t.references :category, index: true, foreign_key: true
      t.references :categoryable, index: true, polymorphic: true
      t.index [
        :categoryable_type, :categoryable_id, :category_id
        ], unique: true, name: 'unique_of_category_categoryables_index'

      t.timestamps
    end
  end
end
