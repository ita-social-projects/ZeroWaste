namespace :db do
  desc "Dumps the database"
  task :dump, [:filename] => :environment do |t, args|
    # pg_dump options:
    # -F c        - output file format custom
    # -d DBNAME   - database name to dump
    # -f FILENAME - output file or directory name
    cmd = "pg_dump -F c -d #{DatabaseService.database_name} -f #{DatabaseService.backup_full_path(args[:filename])}"

    puts system(cmd) ? "Database dump created..." : "Error to create database dump!!!"
  end

  desc "Restores the database dump"
  task :restore, [:filename] => :environment do |t, args|
    raise "You must specify a filename" unless args[:filename]

    # pg_restore options:
    # -c          -  clean (drop) database objects before recreating
    # -F c        - output file format custom
    # -d DBNAME   - database name to dump
    cmd = "pg_restore -c -F c -d #{DatabaseService.database_name} #{DatabaseService.backup_full_path(args[:filename])}"

    puts system(cmd) ? "Database restored..." : "Error to restore database!!!"
  end

  desc "Show the existing database backups"
  task dumps: :environment do
    backup_dir = DatabaseService.init_backup_directory
    puts backup_dir.to_s
    system "/bin/ls -ltR #{backup_dir}"
  end
end
