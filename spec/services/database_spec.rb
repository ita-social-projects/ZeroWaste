require "rails_helper"

RSpec.describe DatabaseService do
  let(:command_enable) { "rake 'db:dump[zero_waste_sandbox.dump]'" }
  let(:command_disable) { "rake 'db:restore[zero_waste_sandbox.dump]'" }
  let(:backup_file) { DatabaseService.backup_full_path(DatabaseService::BACKUP_SANDBOX_NAME) }
  let(:new_file_path) { File.join(DatabaseService::BACKUP_ARCHIVE_DIR, "zero_waste_sandbox.dump") }
  let(:new_file_path_regex) { Regexp.new("#{Regexp.escape(DatabaseService::BACKUP_ARCHIVE_DIR.to_s)}/\\d{14}_zero_waste_sandbox\\.dump") }
  let(:files) { ["older.dump", "newest.dump"] }
  let(:file_name) { "test.dump" }

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

  describe ".init_backup_directory" do
    it "creates the backup directory if it does not exist" do
      expect(FileUtils).to receive(:mkdir_p).with(DatabaseService::BACKUP_DIR)

      DatabaseService.init_backup_directory
    end

    it "returns the backup directory path" do
      expect(DatabaseService.init_backup_directory).to eq(DatabaseService::BACKUP_DIR)
    end
  end

  describe ".backup_full_path" do
    context "when file name is provided" do
      it "returns the full backup path with the provided file name" do
        expect(DatabaseService.backup_full_path(file_name)).to eq(File.join(DatabaseService::BACKUP_DIR, file_name))
      end
    end

    context "when file name is not provided" do
      it "returns the full backup path with a generated file name" do
        allow(DatabaseService).to receive(:generate_backup_filename).and_return("generated_filename.dump")

        expect(DatabaseService.backup_full_path).to include("generated_filename.dump")
      end
    end
  end

  describe ".copy_to_archive" do
    before do
      allow(Time.current).to receive(:strftime).with("%Y%m%d%H%M%S").and_return("timestamp")
      allow(FileUtils).to receive(:cp)
      allow(FileUtils).to receive(:rm)
    end

    it "copies the backup file to the archive directory" do
      expect(FileUtils).to receive(:cp).with(backup_file, match(new_file_path_regex))

      DatabaseService.copy_to_archive(backup_file)
    end

    it "removes the original backup file" do
      expect(FileUtils).to receive(:rm).with(backup_file)

      DatabaseService.copy_to_archive(backup_file)
    end

    it "calls prune_old_backups if archive directory exceeds max backups" do
      allow(Dir).to receive(:entries).and_return(Array.new(11, "file.dump"))
      expect(DatabaseService).to receive(:prune_old_backups)

      DatabaseService.copy_to_archive(backup_file)
    end
  end

  describe ".generate_backup_filename" do
    it "generates a backup filename with the current timestamp and database name" do
      allow(DatabaseService).to receive(:database_name).and_return(file_name)

      expect(DatabaseService.send(:generate_backup_filename)).to include(file_name)
    end
  end

  describe ".prune_old_backups" do
    before do
      allow(Dir).to receive(:entries).and_return(files)
      allow(File).to receive(:file?).and_return(true)
      allow(File).to receive(:mtime)
      allow(FileUtils).to receive(:rm)
    end

    it "removes the oldest backup file in the archive directory" do
      allow(File).to receive(:mtime).with(anything).and_return(Time.current)
      allow(File).to receive(:mtime).with(File.join(DatabaseService::BACKUP_ARCHIVE_DIR, "older.dump")).and_return(Time.current - 60)
      expect(FileUtils).to receive(:rm).with(File.join(DatabaseService::BACKUP_ARCHIVE_DIR, "older.dump"))

      DatabaseService.send(:prune_old_backups)
    end
  end
end
