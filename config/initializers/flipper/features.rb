if Flipper::Adapters::ActiveRecord::Feature.table_exists?
  require_relative "flipper_feature"

  Flipper[:new_calculator_design].en_description = "This feature flag is responsible for enabling new calculator design"
  Flipper[:new_calculator_design].uk_description = "Відкриває можливість використовувати новий дизайн калькулятора"

  Flipper[:show_calculators_list].en_description = "This feature flag controls the visibility of calculators on the public side"
  Flipper[:show_calculators_list].uk_description = "Цей прапорець відображає або приховує калькулятори на публічній стороні"
end
