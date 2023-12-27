require "rails_helper"

RSpec.describe DatabaseBackupService do
  let(:command_enable) { "rake 'db:backup:create[zero_waste_sandbox.dump]'" }
  let(:command_disable) { "rake 'db:backup:restore[zero_waste_sandbox.dump]'" }
  let(:backup_archive_dir) { DatabaseBackupService.backup_archive_dir }
  let(:backup_file) { DatabaseBackupService.backup_full_path(DatabaseBackupService::BACKUP_SANDBOX_NAME) }
  let(:new_file_path) { File.join(backup_archive_dir, "zero_waste_sandbox.dump") }
  let(:new_file_path_regex) { Regexp.new("#{Regexp.escape(backup_archive_dir.to_s)}/\\d{14}_zero_waste_test\\.dump") }
  let(:files) { ["older.dump", "newest.dump"] }
  let(:file_name) { "test.dump" }

  describe ".database_name" do
    it "returns the name of the current database" do
      expect(DatabaseBackupService.database_name).to eq(ActiveRecord::Base.connection.current_database)
    end
  end

  describe ".backup_dir" do
    it "returns the backup directory path" do
      expect(DatabaseBackupService.backup_dir.to_s).to include("db/backups")
    end
  end

  describe ".backup_archive_dir" do
    it "returns the backup archive directory path" do
      expect(DatabaseBackupService.backup_archive_dir.to_s).to include("db/backups/archive")
    end
  end

  describe ".backup_full_path" do
    context "when file name is provided" do
      it "returns the full backup path with the provided file name" do
        expect(DatabaseBackupService.backup_full_path(file_name)).to eq(File.join(DatabaseBackupService.backup_dir, file_name))
      end
    end

    context "when file name is not provided" do
      it "returns the full backup path with a generated file name" do
        allow(DatabaseBackupService).to receive(:generate_backup_filename).and_return("generated_filename.dump")

        expect(DatabaseBackupService.backup_full_path).to include("generated_filename.dump")
      end
    end
  end

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
        allow(FileUtils).to receive(:mv).with(backup_file, anything)

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

  describe ".copy_to_archive" do
    before do
      allow(Time.current).to receive(:strftime).with("%Y%m%d%H%M%S").and_return("timestamp")
      allow(FileUtils).to receive(:mv)
    end

    it "move the backup file to the archive directory" do
      expect(FileUtils).to receive(:mv).with(backup_file, match(new_file_path_regex))

      DatabaseBackupService.copy_to_archive(backup_file)
    end

    it "calls prune_old_backups if archive directory exceeds max backups" do
      allow(Dir).to receive(:glob).and_return(Array.new(11, "file.dump"))
      expect(DatabaseBackupService).to receive(:prune_old_backups)

      DatabaseBackupService.copy_to_archive(backup_file)
    end
  end

  describe ".generate_backup_filename" do
    it "generates a backup filename with the current timestamp and database name" do
      allow(DatabaseBackupService).to receive(:database_name).and_return(file_name)

      expect(DatabaseBackupService.send(:generate_backup_filename)).to include(file_name)
    end
  end

  describe ".prune_old_backups" do
    before do
      allow(Dir).to receive(:glob).with(File.join(backup_archive_dir, "*")).and_return(files)
      allow(File).to receive(:file?).and_return(true)
      allow(File).to receive(:mtime)
      allow(FileUtils).to receive(:rm)
    end

    it "removes the oldest backup file in the archive directory" do
      allow(File).to receive(:mtime).with(anything).and_return(Time.current)
      allow(File).to receive(:mtime).with(File.join(backup_archive_dir, "older.dump")).and_return(Time.current - 60)
      expect(FileUtils).to receive(:rm).with("older.dump")

      DatabaseBackupService.send(:prune_old_backups)
    end
  end

  describe ".exceeds_backup_limit?" do
    context "when the number of backup files is below the limit" do
      it "returns false" do
        allow(Dir).to receive(:glob).with(File.join(backup_archive_dir, "*")).and_return(Array.new(9, "backup_file"))
        expect(described_class.exceeds_backup_limit?).to be(false)
      end
    end

    context "when the number of backup files is at the limit" do
      it "returns true" do
        allow(Dir).to receive(:glob).with(File.join(backup_archive_dir, "*")).and_return(Array.new(10, "backup_file"))
        expect(described_class.exceeds_backup_limit?).to be(true)
      end
    end

    context "when the number of backup files exceeds the limit" do
      it "returns true" do
        allow(Dir).to receive(:glob).with(File.join(backup_archive_dir, "*")).and_return(Array.new(11, "backup_file"))
        expect(described_class.exceeds_backup_limit?).to be(true)
      end
    end
  end
end
