module LanguageHelper
  class UkrLanguageHelper
    def receive_correct_diapers_form(diapers)
      diapers = diapers.round()
      last_2_numbers = diapers.to_s[-2..-1]
      last_1_number = diapers.to_s[-1]
      if (last_1_number == '1') && (last_2_numbers != '11')
        'підгузок'
      elsif %w[2 3
               4].include?(last_1_number) && (last_2_numbers != '12' && last_2_numbers != '13' && last_2_numbers != '14')
        'підгузки'
      else
      'підгузків'
      end
    end
  end
end
