# frozen_string_literal: true

FactoryBot.define do
  factory :diapers_service, class: Calculators::DiapersService do
    initialize_with { new(0, 8) }
    used_diapers_amount { 0 }
    used_diapers_price { 0 }
    to_be_used_diapers_amount { 4575 }
    to_be_used_diapers_price { 23_332.5 }
    config do
      {
        "1..3" => {
          "amount" => 10,
          "price" => 4
        },
        "4..6" => {
          "amount" => 8,
          "price" => 4.5
        },
        "7..9" => {
          "amount" => 6,
          "price" => 5
        }
      }
    end
  end
end
