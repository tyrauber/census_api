require 'spec_helper'

describe CensusApi::Client do

  describe "client initialization" do

    use_vcr_cassette "initialize_client"

    it 'should not initialize without an api_key' do
      lambda { CensusApi::Client.new }.should raise_error
    end

    it 'should initialize with an api_key' do
      @client = CensusApi::Client.new(api_key)
      @client.api_key.should == api_key
    end
  end

  describe "client and dataset initialization" do

    use_vcr_cassette "initialize_client_and_dataset"

    it 'should initialize with an api_key and dataset' do
      dataset = 'SF1'
      @client = CensusApi::Client.new(api_key, dataset: dataset)
      @client.api_key.should == api_key
      @client.dataset.should == dataset.downcase
    end

    it 'should request sf1' do
      source, options = 'sf1', {:key=> api_key, :vintage => 2010, :fields => 'P0010001', :level => 'STATE:06', :within=>[]}
      @client = CensusApi::Client.new(api_key, dataset: source)
      CensusApi::Request.should_receive(:find).with(@client.dataset, options)
      @client.find(options[:fields], options[:level])
    end

    it 'should request acs5' do
      source, options = 'acs5', {:key=> api_key, :vintage => 2010, :fields => 'B00001_001E', :level => 'STATE:06', :within=>[]}
      @client = CensusApi::Client.new(api_key, dataset: source)
      CensusApi::Request.should_receive(:find).with(@client.dataset, options)
      @client.find(options[:fields], options[:level])
    end
  end
end