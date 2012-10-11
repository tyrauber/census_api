# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'census_api/version'

Gem::Specification.new do |gem|
  gem.name          = "census_api"
  gem.version       = CensusApi::VERSION
  gem.authors       = ["Ty Rauber"]
  gem.email         = ["tyrauber@mac.com"]
  gem.description   = %q{A Ruby Gem for querying the US Census Bureau API}
  gem.summary       = %q{A Ruby Wrapper for the US Census Bureau API, providing the ability to query both the 2010 Census and 2006-2010 ACS5 datasets.}
  gem.homepage      = "https://github.com/tyrauber/census_api.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_runtime_dependency "rest-client"
  gem.add_runtime_dependency "hpricot"
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
  gem.add_development_dependency 'vcr'
end
