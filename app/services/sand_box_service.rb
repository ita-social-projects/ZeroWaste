class SandBoxService
  def self.enable(flag)
    database_name = ActiveRecord::Base.connection.current_database

    command = if flag
      "pg_dump -F c #{database_name} -f tmp/zero_waste.dump"
    else
      "pg_restore -d #{database_name} --clean tmp/zero_waste.dump"
    end
    system(command)
  end
end
