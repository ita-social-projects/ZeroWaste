namespace :db do
  namespace :backup do
    desc "Create the database dump"
    task :create, [:filename] => :environment do |t, args|
      # pg_dump options:
      # -F c        - output file format custom
      # -d DBNAME   - database name to dump
      # -f FILENAME - output file or directory name
      cmd = "pg_dump -F c -d #{DatabaseBackupService.database_name} -f #{DatabaseBackupService.backup_full_path(args[:filename])}"

      puts system(cmd) ? "Created dump database #{DatabaseBackupService.database_name}" : "Error to create database dump!!!"
    end

    desc "Restores the database dump"
    task :restore, [:filename] => :environment do |t, args|
      raise "You must specify a filename" unless args[:filename]

      backup_file_name = DatabaseBackupService.backup_full_path(args[:filename])
      # pg_restore options:
      # -c          -  clean (drop) database objects before recreating
      # -F c        - output file format custom
      # -d DBNAME   - database name to dump
      cmd              = "pg_restore -c -F c -d #{DatabaseBackupService.database_name} #{backup_file_name}"

      puts system(cmd) ? "Database restored from #{backup_file_name}" : "Error to restore database from  #{backup_file_name}!!!"
    end

    desc "Show the existing database backups"
    task list: :environment do
      system "/bin/ls -ltR #{DatabaseBackupService.backup_dir}"
    end
  end
end
