class InitAppConfig < ActiveRecord::Migration[6.1]
  def up
    config = AppConfig.instance
    config.diapers_calculator = {
      (1..3) => {
        amount: 10,
        price: 4
      },
      (4..6) => {
        amount: 8,
        price: 4.5
      },
      (7..9) => {
        amount: 6,
        price: 5
      },
      (10..12) => {
        amount: 6,
        price: 5.5
      },
      (13..18) => {
        amount: 4,
        price: 5.5
      },
      (19..24) => {
        amount: 4,
        price: 6
      },
      (25..30) => {
        amount: 2,
        price: 6
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
