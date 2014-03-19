require "rspec/autorun"

require "logger"
$logger = Logger.new(STDERR)

require "dotenv"
APP_ENV ||= "test"
Dotenv.load ".#{APP_ENV}.env", ".env"

require "rexis"
Rexis::Server.set :root, File.expand_path("../..", __FILE__)

RSpec.configure do |config|
  config.after(:suite) do
    # erase everything
    Rexis::Registry.filter.delete
  end
end
