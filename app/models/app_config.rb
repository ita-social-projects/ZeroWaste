class AppConfig < ApplicationRecord
  self.table_name = "app_config"
  @instance = new
  def self.instance
    @instance
  end

  class << self
    private new
  end
end