FactoryBot.define do
  factory :app_config do
    diapers_calculator do
      {
        "1..3" => { "price" => "7.5", "amount" => "10" },
        "4..6" => { "price" => "10", "amount" => "8" },
        "7..9" => { "price" => "9", "amount" => "6" },
        "10..12" => { "price" => "10.5", "amount" => "6" },
        "13..18" => { "price" => "10.5", "amount" => "4" },
        "19..24" => { "price" => "12.5", "amount" => "4" },
        "25..30" => { "price" => "12.5", "amount" => "2" }
      }
    end

    initialize_with { AppConfig.instance }

    trait :updated do
      diapers_calculator do
        {
          "1..3" => { "price" => "8", "amount" => "10" },
          "4..6" => { "price" => "10", "amount" => "8" },
          "7..9" => { "price" => "9", "amount" => "6" },
          "10..12" => { "price" => "10.5", "amount" => "6" },
          "13..18" => { "price" => "10.5", "amount" => "4" },
          "19..24" => { "price" => "12.5", "amount" => "4" },
          "25..30" => { "price" => "12.5", "amount" => "2" }
        }
      end
    end

    factory :diapers_calculator_params do
      first_amount { "10" }
      first_price { "8" }
      second_amount { "8" }
      second_price { "10" }
      third_amount { "6" }
      third_price { "9" }
      fourth_amount { "6" }
      fourth_price { "10.5" }
      fifth_amount { "4" }
      fifth_price { "10.5" }
      sixth_amount { "4" }
      sixth_price { "12.5" }
      seventh_amount { "2" }
      seventh_price { "12.5" }
    end
  end
end
