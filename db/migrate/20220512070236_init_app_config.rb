class InitAppConfig < ActiveRecord::Migration[6.1]
  def up
    config = AppConfig.instance
    config.diapers_calculator = {
      age_periods: {
        first: {
          avg_amount: 10,
          avg_price: 4,
          period_duration: 3
        },
        second: {
          avg_amount: 8,
          avg_price: 4.5,
          period_duration: 3
        },
        third: {
          avg_amount: 6,
          avg_price: 5,
          period_duration: 3
        },
        fourth: {
          avg_amount: 6,
          avg_price: 5.5,
          period_duration: 3
        },
        fifth: {
          avg_amount: 4,
          avg_price: 5.5,
          period_duration: 6
        },
        sixth: {
          avg_amount: 4,
          avg_price: 6,
          period_duration: 6
        },
        seventh: {
          avg_amount: 2,
          avg_price: 6,
          period_duration: 6
        }
      }
    }
    config.save
  end

  def down
    config = AppConfig.instance
    config.diapers_calculator = {}
    config.save
  end
end
