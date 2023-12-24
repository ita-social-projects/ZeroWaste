class DatabaseService
  BACKUP_SANDBOX_NAME = "zero_waste_sandbox.dump".freeze
  BACKUP_DIR          = Rails.root.join("db", "backups").freeze
  BACKUP_ARCHIVE_DIR  = Rails.root.join(BACKUP_DIR, "archive").freeze
  MAX_NUMBER_BACKUP   = 10

  class << self
    def sandbox_enable(dump_flag)
      dump_flag.tap do
        return dump_flag if sandbox_enabled? == dump_flag

        operation = dump_flag ? "dump" : "restore"
        command   = "rake 'db:#{operation}[#{BACKUP_SANDBOX_NAME}]'"

        return !dump_flag unless system(command)

        copy_to_archive(backup_full_path(BACKUP_SANDBOX_NAME)) unless dump_flag
      end
    end

    def sandbox_enabled?
      backup_file = File.join(BACKUP_DIR, BACKUP_SANDBOX_NAME)

      File.exist?(backup_file)
    end

    def init_backup_directory
      ensure_directory_exists(BACKUP_DIR)

      BACKUP_DIR
    end

    def backup_full_path(file_name = "")
      file_name = generate_backup_filename if file_name.blank?

      File.join(init_backup_directory, file_name)
    end

    def database_name
      ActiveRecord::Base.connection.current_database
    end

    def copy_to_archive(backup_file)
      ensure_directory_exists(BACKUP_ARCHIVE_DIR)

      prune_old_backups if Dir.entries(BACKUP_ARCHIVE_DIR).count > MAX_NUMBER_BACKUP

      timestamp     = Time.current.strftime("%Y%m%d%H%M%S")
      new_file_name = "#{timestamp}_#{File.basename(backup_file)}"
      new_file_path = File.join(BACKUP_ARCHIVE_DIR, new_file_name)

      FileUtils.cp(backup_file, new_file_path)
      FileUtils.rm(backup_file)
    end

    private_class_method

    def ensure_directory_exists(directory)
      FileUtils.mkdir_p(directory)
    end

    def generate_backup_filename
      "#{Time.current.strftime("%Y%m%d%H%M%S")}_#{database_name}.dump"
    end

    def prune_old_backups
      files       = Dir.entries(BACKUP_ARCHIVE_DIR).select { |f| File.file?(File.join(BACKUP_ARCHIVE_DIR, f)) }
      oldest_file = files.min_by { |f| File.mtime(File.join(BACKUP_ARCHIVE_DIR, f)) }

      FileUtils.rm(File.join(BACKUP_ARCHIVE_DIR, oldest_file))
    end
  end
end
