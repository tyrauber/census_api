require 'spec_helper'

describe CensusApi::Client do

  it 'should not initialize without an api_key' do
    lambda { CensusApi::Client.new }.should raise_error
  end

  it 'should not initialize without a proper api key' do
    VCR.use_cassette('api_key_invalid') do
      lambda { CensusApi::Client.new('abcdef') }.should raise_error
    end
  end

  it 'should initialize with an api_key' do
    VCR.use_cassette('api_key_works') do
      @client = CensusApi::Client.new(api_key)
      @client.api_key.should == api_key
    end
  end

  it 'should initialize with an api_key and dataset' do
    VCR.use_cassette('api_key_works') do
      dataset = 'SF1'
      @client = CensusApi::Client.new(api_key, dataset: dataset)
      @client.api_key.should == api_key
      @client.dataset.should == dataset.downcase
    end
  end

  it 'should request sf1' do
    VCR.use_cassette('api_key_works') do
      fields = 'P0010001'
      level = 'STATE:06'
      options = {:within=>[]}
      @client = CensusApi::Client.new(api_key, dataset: 'sf1')
      CensusApi::Request.should_receive(:find).with(@client.dataset, @client.api_key, fields, level, options)
      @client.find(fields, level)
    end
  end

  it 'should request acs5' do
    VCR.use_cassette('api_key_works') do
      fields = 'B00001_001E'
      level = 'STATE:06'
      options = {:within=>[]}
      @client = CensusApi::Client.new(api_key, dataset: 'acs5')
      CensusApi::Request.should_receive(:find).with(@client.dataset, @client.api_key, fields, level, options)
      @client.find(fields, level)
    end
  end
  
end