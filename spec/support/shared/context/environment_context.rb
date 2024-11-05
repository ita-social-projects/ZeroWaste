RSpec.shared_context :in_production_environment do
  before do
    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
  end
end

RSpec.shared_context :in_local_environment do
  before do
    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("local"))
  end
end
