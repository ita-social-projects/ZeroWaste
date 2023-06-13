class ChangeProductTypes < ActiveRecord::Migration[6.1]
  def up
    ProductType.create(title: "Diapers")
    ProductType.create(title: "Menstrual hygiene")
  end

  def down
    begin
      ProductType.destroy_by(title: "Diapers")
      ProductType.destroy_by(title: "Menstrual hygiene")
    rescue StandardError
      ActiveRecord::Base.connection.execute 'ROLLBACK'
    end
  end
end
