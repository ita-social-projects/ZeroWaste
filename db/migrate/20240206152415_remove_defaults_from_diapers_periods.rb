class RemoveDefaultsFromDiapersPeriods < ActiveRecord::Migration[7.1]
  def up
    change_table :diapers_periods, bulk: true do |t|
      t.change_default :period_start, nil
      t.change_default :period_end, nil
      t.change_default :usage_amount, nil
    end
  end

  def down
    change_table :diapers_periods, bulk: true do |t|
      t.change_default :period_start, 0
      t.change_default :period_end, 0
      t.change_default :usage_amount, 0
    end
  end
end
