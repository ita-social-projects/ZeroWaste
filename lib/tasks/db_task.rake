namespace :db do
  desc "Dumps the database"
  task :dump, [:filename] => :environment do |t, args|
    cmd = "pg_dump -F c -d #{DatabaseService.database_name} -f #{DatabaseService.backup_full_path(args[:filename])}"

    puts system(cmd) ? "Database dump created..." : "Error to create database dump!!!"
  end

  desc "Restores the database dump"
  task :restore, [:filename] => :environment do |t, args|
    raise "You must specify a filename" unless args[:filename]

    cmd = "pg_restore --clean -d #{DatabaseService.database_name} #{DatabaseService.backup_full_path(args[:filename])}"

    puts system(cmd) ? "Database restored..." : "Error to restore database!!!"
  end

  desc "Show the existing database backups"
  task dumps: :environment do
    backup_dir = DatabaseService.backup_directory
    puts backup_dir.to_s
    system "/bin/ls -ltR #{backup_dir}"
  end
end
