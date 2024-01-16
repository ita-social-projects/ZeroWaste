class DatabaseBackupService
  BACKUP_SANDBOX_NAME = "zero_waste_sandbox.dump".freeze
  MAX_NUMBER_BACKUP   = 10

  class << self
    def database_name
      ActiveRecord::Base.connection.current_database
    end

    def backup_dir
      @backup_dir ||= Rails.root.join("db", "backups")
    end

    def backup_archive_dir
      @backup_archive_dir ||= Rails.root.join(backup_dir, "archive")
    end

    def backup_full_path(file_name = "")
      file_name = generate_backup_filename if file_name.blank?

      File.join(backup_dir, file_name)
    end

    def sandbox_enable(dump_flag)
      dump_flag.tap do
        return dump_flag if sandbox_enabled? == dump_flag

        operation = dump_flag ? "create" : "restore"
        command   = "rake 'db:backup:#{operation}[#{BACKUP_SANDBOX_NAME}]'"

        return !dump_flag unless system(command)

        copy_to_archive(backup_full_path(BACKUP_SANDBOX_NAME)) unless dump_flag
      end
    end

    def sandbox_enabled?
      backup_file = File.join(backup_dir, BACKUP_SANDBOX_NAME)

      File.exist?(backup_file)
    end

    def copy_to_archive(backup_file)
      prune_old_backups if exceeds_backup_limit?

      new_file_name = generate_backup_filename
      new_file_path = File.join(backup_archive_dir, new_file_name)

      FileUtils.mv(backup_file, new_file_path)
    end

    private_class_method

    def generate_backup_filename
      "#{Time.current.strftime("%Y%m%d%H%M%S")}_#{database_name}.dump"
    end

    def prune_old_backups
      files       = Dir.glob(File.join(backup_archive_dir, "*")).select { |f| File.file?(f) }
      oldest_file = files.min_by { |f| File.mtime(f) }

      FileUtils.rm(oldest_file) if oldest_file
    end

    def exceeds_backup_limit?
      Dir.glob(File.join(backup_archive_dir, "*")).size >= MAX_NUMBER_BACKUP
    end
  end
end
