if Flipper::Adapters::ActiveRecord::Feature.table_exists?
  require_relative "flipper_feature"

  Flipper[:new_calculator_design].en_description = "This feature flag is responsible for enabling new calculator design"
  Flipper[:new_calculator_design].uk_description = "Відкриває можливість використовувати новий дизайн калькулятора"

  Flipper[:show_calculators_list].en_description = "This feature flag controls the visibility of the calculators page on the public side"
  Flipper[:show_calculators_list].uk_description = "Цей прапорець відображає або приховує сторінку калькуляторів на публічній стороні"

  Flipper[:sandbox_mode].en_description = "This feature flag is responsible for enabling sandbox mode"
  Flipper[:sandbox_mode].uk_description = "Відкриває можливість використовувати режим пісочниці"
end
