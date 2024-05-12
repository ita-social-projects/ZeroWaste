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

RSpec.shared_context :hide_calculators_list do
  before do
    FeatureFlag.find_or_create_by!(name: "show_calculators_list")
    Flipper.disable(:show_calculators_list)
  end
end

def sandbox_mode_context(mode)
  RSpec.shared_context :"sandbox_mode_#{mode}" do
    before do
      FeatureFlag.find_or_create_by!(name: "sandbox_mode")
      Flipper.send(mode, :sandbox_mode)
    end
  end
end

sandbox_mode_context(:enable)
sandbox_mode_context(:disable)
