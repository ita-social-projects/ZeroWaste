require "rails_helper"

RSpec.describe SandBox do
  let(:command_enable) { "pg_dump -F c zero_waste_development -f tmp/zero_waste.dump" }
  let(:command_disable) { "pg_restore -d zero_waste_development --clean tmp/zero_waste.dump" }

  describe "SandBox" do
    context "when flag is true" do
      it "runs pg_dump command" do
        expect(SandBox).to receive(:system).with(command_enable).and_return(true)
        SandBox.enable(true)
      end
    end

    context "when flag is false" do
      it "runs pg_restore command" do
        expect(SandBox).to receive(:system).with(command_disable).and_return(true)
        SandBox.enable(false)
      end
    end
  end
end
