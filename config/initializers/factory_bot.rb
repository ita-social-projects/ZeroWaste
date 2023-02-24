sequence :first_name do |num|
  if Rails.env.test?
    "#{clear_special_characters(Faker::Name.first_name.strip)} #{num}"
  else
    Faker::Name.first_name
  end
end

if defined?(FactoryBot)
  module FactoryBotCharacters
    def clear_special_characters(string)
      string.gsub(/[^0-9A-Za-zа-яА-Я ]/, "")
    end
  end

  class FactoryBot::SyntaxRunner
    include FactoryBotCharacters
  end
end
