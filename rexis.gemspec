# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rexis/version'

Gem::Specification.new do |gem|
  gem.required_ruby_version = '~> 2.1'

  gem.name          = "rexis"
  gem.version       = Rexis::VERSION
  gem.authors       = ["Jason W. May"]
  gem.email         = ["jmay@pobox.com"]
  gem.description   = %q{Link Registry}
  gem.summary       = %q{Central registry for URLs}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "sinatra", "~> 1.4"
  gem.add_dependency 'thin', "~> 1.5"
  gem.add_dependency 'haml', "~> 4.0"
  gem.add_dependency "sequel", "~> 4.7"
  gem.add_dependency "pg", "~> 0.17"
  gem.add_dependency "dotenv", "~> 0.9"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "guard-minitest"
  gem.add_development_dependency "ruby_gntp"
  gem.add_development_dependency "rack-test"
end
