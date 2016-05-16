# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'census_api/version'

Gem::Specification.new do |gem|
  gem.name          = 'census_api'
  gem.version       = CensusApi::VERSION
  gem.authors       = ['Ty Rauber']
  gem.license       = 'MIT'
  gem.email         = ['tyrauber@mac.com']
  gem.description   = 'A Ruby Gem for querying the US Census Bureau API'
  gem.summary       = 'A Ruby Wrapper for the US Census Bureau API,
                      providing the ability to query both the SF1 and ACS5
                      datasets.'
  gem.homepage      = 'https://github.com/tyrauber/census_api.git'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n")
                      .map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'http'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock', '< 2.0'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'rubocop'
end
