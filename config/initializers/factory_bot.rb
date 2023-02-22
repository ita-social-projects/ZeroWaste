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
