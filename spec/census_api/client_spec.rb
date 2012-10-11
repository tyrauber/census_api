require 'spec_helper'

describe CensusApi::Client do

  it 'should not initialize without an api_key' do
    lambda { CensusApi::Client.new }.should raise_error
  end

  it 'should initialize with an api_key' do
    @client = CensusApi::Client.new(api_key)
    @client.api_key.should == api_key
  end

  it 'should request sf1' do
    source, options = 'sf1', {:key=> api_key, :fields => 'P0010001', :level => 'STATE:06', :within=>[]}
    @client = CensusApi::Client.new(api_key)
    CensusApi::Request.should_receive(:find).with(source, options)
    @client.sf1(options[:fields], options[:level])
  end

  it 'should request acs5' do
    source, options = 'acs5', {:key=> api_key, :fields => 'B00001_001E', :level => 'STATE:06', :within=>[]}
    @client = CensusApi::Client.new(api_key)
    CensusApi::Request.should_receive(:find).with(source, options)
    @client.acs5(options[:fields], options[:level])
  end
  
end