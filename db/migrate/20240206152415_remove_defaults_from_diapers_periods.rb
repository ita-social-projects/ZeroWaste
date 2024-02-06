class RemoveDefaultsFromDiapersPeriods < ActiveRecord::Migration[7.1]
  def change
    change_table :diapers_periods, bulk: true do |t|
      t.change_default :period_start, nil
      t.change_default :period_end, nil
      t.change_default :usage_amount, nil
    end
  end
end
