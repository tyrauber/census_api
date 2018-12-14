require 'rubygems'
require 'bundler/setup'
require 'vcr_setup'
require 'census_api'
require 'support/examples'

# => Generate Suite from Census Examples
# Request Examples as JSON from the Census and generate the test suite.

EXAMPLES = [
  [2012, 'acs', 'acs1'],
  [2010, "dec", "sf1"],
  [2015, "acs", "acs5"]
]

# {source: 'acs1', from: 2012, to: 2015, new_endpoint: 'acs/acs1'},
# {source: 'acs3', from: 2012, to: 2013, new_endpoint: 'acs/acs3'},
# {source: 'acs5', from: 2010, to: 2015, new_endpoint: 'acs/acs5'},
# {source: 'acsse', from: 2014, to: 2015, new_endpoint: 'acs/acsse'},
# {source: 'sf1', from: 2010, to: 2010, new_endpoint: 'dec/sf1'}
#

EXAMPLES.each do |example|
  VCR.use_cassette('census', :record => :new_episodes) do
    generate(example)
  end
 require "support/data/census_#{example.join("_")}"


 # p "https://api.census.gov/data/#{example.join("/")}/examples.json"
  #generate("census_2010_dec_sf1")
end
# generate("census_2010_dec_sf1", "https://api.census.gov/data/2010/dec/sf1/examples.json")
# generate("census_2015_acs_acs5", "https://api.census.gov/data/2015/acs/acs5/examples.json")


#examples = Dir.glob('path/**/*').select{ |e| File.file? e }
# examples.each do
# p examples