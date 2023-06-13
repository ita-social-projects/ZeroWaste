class ChangeProducts < ActiveRecord::Migration[6.1]
  def up
    ProductType.find_by(title: "Diapers").products.create([{ title: "Diapers" }, { title: "Reusable diapers" }])
  end

  def down
    begin
      ProductType.find_by(title: "Diapers").products.destroy_all
    rescue StandardError
      ActiveRecord::Base.connection.execute 'ROLLBACK'
    end
  end
end
