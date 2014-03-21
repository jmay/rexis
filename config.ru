# require "dotenv"
#
# APP_ENV ||= ENV["APP_ENV"] || ENV["RACK_ENV"] || "development"
# Dotenv.load ".#{APP_ENV}.env", ".env"

require "rexis"

Rexis::Server.set :root, File.dirname(__FILE__)

map "/" do
  run Rexis::Server.new(
    registry: Rexis::Registry.new,
    domain: ENV["REXIS_DOMAIN"]
    )
end
