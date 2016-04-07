namespace :init_task do

  desc "Reseed and backup all--assumes current is canonic"
  task :backup  => :environment do
    puts 'seed...'
    system "rake db:seed"

    puts 'dump...'
    system "rake db:dump"

    puts "load..."
    system "rake db:load"

    puts "copy sqlite3 to closet/backups..."
    system "cp db/development.sqlite3 data/tcsampleapp.sqlite3"
  end

  desc "Truncate the wirelog"
  task :truncate_wirelog => :environment do
    wire_log_file = File.truncate(Rails.application.config.wire_log.output_file_name, 0)
  end
end
