RSpec.shared_context :enable_admin_menu do
  before do
    flag = FeatureFlag.find_or_create_by!(name: "access_admin_menu")
    Flipper.public_send("enable", "access_admin_menu")
  end
end

RSpec.shared_context :disable_admin_menu do
  before do
    flag = FeatureFlag.find_or_create_by!(name: "access_admin_menu")
    Flipper.public_send("disable", "access_admin_menu")
  end
end

RSpec.shared_context :new_calculator_design do
  before do
    flag = FeatureFlag.find_or_create_by!(name: "new_calculator_design")
    Flipper.public_send("enable", "new_calculator_design")
  end
end

RSpec.shared_context :old_calculator_design do
  before do
    flag = FeatureFlag.find_or_create_by!(name: "new_calculator_design")
    Flipper.public_send("disable", "new_calculator_design")
  end
end
