require "sequel"
Sequel.connect(ENV["DATABASE_URL"])

module Rexis
end

%w(
  version
  registry registry_server
  item
  ).each do |f|
  require_relative "rexis/#{f}"
end
