namespace :db do
  desc "Delete and recreate the database"
  task :recreate => :environment do
    puts "Destroying current database"
    rails db:drop
    puts "Creating Database"
    rails db:create
    puts "Running migration files..."
    rails db:migrate
    puts "Running seed data"
    rails db:seed
    puts "Complete, database has been reset"

  end
end
