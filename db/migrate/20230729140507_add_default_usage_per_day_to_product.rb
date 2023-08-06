class AddDefaultUsagePerDayToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :default_usage_per_day, :integer, null: false, default: 1
  end
end