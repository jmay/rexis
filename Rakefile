# require "bundler/gem_tasks"
#
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

# require 'rake/testtask'
#
# Rake::TestTask.new do |t|
#   t.libs.push "test"
#   t.pattern = "test/**/*.rb"
#   t.verbose = true
# end

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    APP_ENV ||= ENV["APP_ENV"] || ENV["RACK_ENV"] || "dev"
    require "dotenv"
    Dotenv.load ".#{APP_ENV}.env", ".env"
    require "sequel"
    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch("DATABASE_URL"))
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "migrations")
    end
  end
end
# task :default => :spec
