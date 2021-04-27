class ChangeProductTypes < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      INSERT INTO product_types (title, created_at, updated_at)
      VALUES ('Diapers', now(), now()), ('Menstrual hygiene', now(), now())
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM product_types WHERE title = 'Diapers';
      DELETE FROM product_types WHERE title = 'Menstrual hygiene'
    SQL
  end
end
