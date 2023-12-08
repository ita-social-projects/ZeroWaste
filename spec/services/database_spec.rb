require "rails_helper"

RSpec.describe DatabaseService do
  let(:command_enable) { "rake 'db:dump[zero_waste_sandbox.dump]'" }
  let(:command_disable) { "rake 'db:restore[zero_waste_sandbox.dump]'" }
  let(:backup_file) { described_class.backup_full_path(described_class::BACKUP_SANDBOX_NAME) }

  describe ".sandbox_enable" do
    context "when dump_flag is true" do
      it "runs dump command and returns true" do
        allow(Kernel).to receive(:system).with(command_enable).and_return(true)
        expect(described_class.sandbox_enable(true)).to eq(true)
      end
    end

    context "when dump_flag is false" do
      it "runs restore command, copies file to archive and returns false" do
        allow(Kernel).to receive(:system).with(command_disable).and_return(true)
        allow(FileUtils).to receive(:cp).with(backup_file, anything)
        expect(described_class.sandbox_enable(false)).to eq(false)
      end
    end
  end

  describe ".sandbox_enabled?" do
    it "checks if the backup file exists" do
      expect(File).to receive(:exist?).with(described_class.backup_full_path(described_class::BACKUP_SANDBOX_NAME)).and_return(true)
      expect(described_class.sandbox_enabled?).to be_truthy
    end
  end
end
