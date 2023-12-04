class SandBoxService
  def self.enable(flag)
    command = "rake 'db:#{flag ? "dump" : "restore"}[zero_waste_sandbox.dump]'"
    system(command)
  end
end
