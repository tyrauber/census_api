require 'rubygems'

%w(version client request).each do |file|
  require File.join(File.dirname(__FILE__), 'census_api', file)
end