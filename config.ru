# require "dotenv"
#
# APP_ENV ||= ENV["APP_ENV"] || ENV["RACK_ENV"] || "development"
# Dotenv.load ".#{APP_ENV}.env", ".env"

require "rexis"
# rexis.config

kinds = ENV["REGISTRY_KINDS"].split(',')

Rexis::Server.set :root, File.dirname(__FILE__)

kinds.each do |kind|
  map "/#{kind}" do
    run Rexis::Server.new(
      registry: Rexis::Registry.new(kind: kind),
      domain: ENV["REGISTRY_DOMAIN"]
      )
  end
end
