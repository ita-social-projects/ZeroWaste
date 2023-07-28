RSpec.shared_context :enable_admin_menu do
  before do
    FeatureFlag.find_or_create_by!(name: "access_admin_menu")
    Flipper.enable :access_admin_menu
  end
end

RSpec.shared_context :disable_admin_menu do
  before do
    FeatureFlag.find_or_create_by!(name: "access_admin_menu")
    Flipper.disable :access_admin_menu
  end
end

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
