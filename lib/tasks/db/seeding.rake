namespace :db do
  namespace :seed do

    desc "Dump the database holding seed data to db/[environment name]_seed.sql."
    task :dump => :environment do
      config = ActiveRecord::Base.configurations[Rails.env]
      dump_cmd = "mysqldump --user=#{config['username']} --password=#{config['password']} #{config['database']} > db/#{Rails.env}_seed.sql"
      system(dump_cmd)
    end

    desc "Load the dumped seed data from db/[environment name]_seed.sql into the development database."
    task :load => :environment do
      config = ActiveRecord::Base.configurations[Rails.env]
      system("mysql --user=#{config['username']} --password=#{config['password']} #{config['database']} < db/#{Rails.env}_seed.sql")
     end
  end
end
