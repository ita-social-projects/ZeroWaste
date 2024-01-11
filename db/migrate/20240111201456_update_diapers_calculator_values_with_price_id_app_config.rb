class UpdateDiapersCalculatorValuesWithPriceIdAppConfig < ActiveRecord::Migration[7.1]
  def up
    AppConfig.instance.tap do |ac|
      ac.diapers_calculator = {
        0 => {
          (1..3) => {
            amount: 10,
            price: 6.25
          },
          (4..6) => {
            amount: 8,
            price: 7.27
          },
          (7..9) => {
            amount: 6,
            price: 7.04
          },
          (10..12) => {
            amount: 6,
            price: 8.38
          },
          (13..18) => {
            amount: 4,
            price: 8.38
          },
          (19..24) => {
            amount: 4,
            price: 9.65
          },
          (25..30) => {
            amount: 2,
            price: 9.65
          }
        },
        1 => {
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
        },
        2 => {
          (1..3) => {
            amount: 10,
            price: 9.37
          },
          (4..6) => {
            amount: 8,
            price: 10.91
          },
          (7..9) => {
            amount: 6,
            price: 10.56
          },
          (10..12) => {
            amount: 6,
            price: 12.56
          },
          (13..18) => {
            amount: 4,
            price: 12.56
          },
          (19..24) => {
            amount: 4,
            price: 14.47
          },
          (25..30) => {
            amount: 2,
            price: 14.47
          }
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
end
