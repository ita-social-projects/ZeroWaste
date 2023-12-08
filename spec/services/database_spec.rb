require "rails_helper"

RSpec.describe DatabaseService do
  let(:command_enable) { "rake 'db:dump[zero_waste_sandbox.dump]'" }
  let(:command_disable) { "rake 'db:restore[zero_waste_sandbox.dump]'" }

  describe "SandBox" do
    context "when flag is true" do
      it "runs pg_dump command" do
        expect(DatabaseService).to receive(:system).with(command_enable).and_return(true)

        DatabaseService.sandbox_enable(true)
      end
    end

    context "when flag is false" do
      it "runs pg_restore command" do
        expect(DatabaseService).to receive(:system).with(command_disable).and_return(true)

        DatabaseService.sandbox_enable(false)
      end
    end
  end
end
