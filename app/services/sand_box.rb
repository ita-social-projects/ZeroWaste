class SandBox
  def self.enable(flag)
    if flag
      command = "pg_dump -F c zero_waste_development -f tmp/zero_waste.dump"
    else
      command = "pg_restore -d zero_waste_development --clean tmp/zero_waste.dump"
    end
    system(command)
  end
end
