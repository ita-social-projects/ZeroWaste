# frozen_string_literal: true

module LanguageHelpers::UkrLanguage
  def correct_word_form(diapers)
    diapers = diapers.round
    last2   = diapers.to_s[-2..]
    last1   = diapers.to_s[-1]

    if (last1 == "1") && (last2 != "11")
      "підгузок"
    elsif ["2", "3", "4"].include?(last1) &&
        (last2 != "12" && last2 != "13" && last2 != "14")
      "підгузки"
    else
      "підгузків"
    end
  end
end
