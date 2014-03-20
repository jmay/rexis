APP_ENV ||= "test"

require "rspec/autorun"

require "logger"
$logger = Logger.new(STDERR)

require "rexis"

Rexis::Server.set :root, File.expand_path("../..", __FILE__)

RSpec.configure do |config|
  config.after(:suite) do
    # erase everything
    Rexis::Code.filter.delete
    Rexis::Item.filter.delete
  end
end
