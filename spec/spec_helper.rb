require 'rubygems'
require 'bundler/setup'
require 'vcr_setup'
require 'api_key'
require 'census_api'
require 'support/census_examples'

def api_key
  RSPEC_API_KEY
end
