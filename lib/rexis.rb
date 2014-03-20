require "sequel"
require "dotenv"

module Rexis
  def self.config
    env||= ENV["APP_ENV"] || ENV["RACK_ENV"] || "development"
    Dotenv.load ".#{env}.env", ".env"

    Sequel.connect(ENV["DATABASE_URL"])
  end
end
Rexis.config

%w(
  version
  registry registry_server
  item code
  ).each do |f|
  require_relative "rexis/#{f}"
end
