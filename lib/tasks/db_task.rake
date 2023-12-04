namespace :db do
  desc "Dumps the database"
  task :dump, [:filename] => :environment do |t, args|
    cmd = "pg_dump -F c -d #{database_name} -f #{backup_full_path(args[:filename])}"

    system cmd
    puts "Database dump created..."
  end

  desc "Restores the database dump"
  task :restore, [:filename] => :environment do |t, args|
    raise "You must specify a filename" unless args[:filename]

    cmd = "pg_restore --clean -d #{database_name} #{backup_full_path(args[:filename])}"

    system cmd
    puts "Database restored..."
  end

  desc "Show the existing database backups"
  task dumps: :environment do
    backup_dir = backup_directory
    puts backup_dir.to_s
    system "/bin/ls -ltR #{backup_dir}"
  end

  private

  def database_name
    ActiveRecord::Base.connection.current_database
  end

  def backup_directory
    backup_dir = Rails.root.join("db", "backups")
    if !Dir.exist?(backup_dir)
      puts "Creating #{backup_dir} .."
      FileUtils.mkdir_p(backup_dir)
    end
    backup_dir
  end

  def backup_full_path(file_name = "")
    backup_dir = backup_directory
    file_name  = "#{Time.current.strftime("%Y%m%d%H%M%S")}_#{database_name}.dump" if file_name.blank?
    "#{backup_dir}/#{file_name}"
  end
end
