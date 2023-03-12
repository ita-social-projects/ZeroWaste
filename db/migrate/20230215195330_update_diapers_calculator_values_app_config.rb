class UpdateDiapersCalculatorValuesAppConfig < ActiveRecord::Migration[6.1]
  def up
    AppConfig.instance.tap do |ac|
      ac.diapers_calculator = {
        (1..3) => {
          amount: 10,
          price: 7.81
        },
        (4..6) => {
          amount: 8,
          price: 9.09
        },
        (7..9) => {
          amount: 6,
          price: 8.8
        },
        (10..12) => {
          amount: 6,
          price: 10.47
        },
        (13..18) => {
          amount: 4,
          price: 10.47
        },
        (19..24) => {
          amount: 4,
          price: 12.06
        },
        (25..30) => {
          amount: 2,
          price: 12.06
        }
      }
      ac.save
    end
  end

  def down
    AppConfig.instance.tap do |ac|
      ac.diapers_calculator = {
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
      ac.save
    end
  end
end
