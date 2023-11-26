RSpec.shared_context :new_calculator_design do
  before do
    FeatureFlag.find_or_create_by!(name: "new_calculator_design")
    Flipper.enable :new_calculator_design
  end
end

RSpec.shared_context :old_calculator_design do
  before do
    FeatureFlag.find_or_create_by!(name: "new_calculator_design")
    Flipper.disable :new_calculator_design
  end
end

RSpec.shared_context :show_calculators_list do
  before do
    FeatureFlag.find_or_create_by!(name: "show_calculators_list")
    Flipper.enable(:show_calculators_list)
  end
end
