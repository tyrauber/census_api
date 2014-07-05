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
  end

  describe "datasets" do

    use_vcr_cassette "find_method"

    it 'should request sf1' do
      source, options = 'sf1', {:key=> api_key, :vintage => 2010, :fields => 'P0010001', :level => 'STATE:06', :within=>[]}
      @client = CensusApi::Client.new(api_key, dataset: source)
      CensusApi::Request.should_receive(:find).with(@client.dataset, options)
      @client.where(options)
    end

    it 'should request acs5' do
      source, options = 'acs5', {:key=> api_key, :vintage => 2010, :fields => 'B00001_001E', :level => 'STATE:06', :within=>[]}
      @client = CensusApi::Client.new(api_key, dataset: source)
      CensusApi::Request.should_receive(:find).with(@client.dataset, options)
      @client.where(options)
    end
  end

  describe "#find" do

    use_vcr_cassette "find_method"

    let(:source) { 'sf1' }
    let(:options) { {:key=> api_key, :vintage => 2010, :fields => 'P0010001', :level => 'STATE:06' } }

    it "should be deprecated" do
       @client = CensusApi::Client.new(api_key, dataset: source)
       @client.should_receive(:warn).with("[DEPRECATION] `find` is deprecated.  Please use `where` with options hash instead.")
       @client.find(options[:fields], options[:level])
    end
  end

  describe "#where" do

     use_vcr_cassette "where_method"

     let(:source) { 'sf1' }
     let(:options) { {:key=> api_key, :vintage => 2010, :fields => 'P0010001', :level => 'STATE:06' } }
     let(:full_params) { {:key=> api_key, :vintage => 2010, :fields => 'P0010001', :level => 'COUNTY:001', :within=>['STATE:06'] } }

     it 'should raise if missing fields params' do
       @client = CensusApi::Client.new(api_key, dataset: source)
       expect { @client.where({fields: options[:fields]}) }.to raise_error(ArgumentError)
     end

     it 'should raise if missing level params' do
       @client = CensusApi::Client.new(api_key, dataset: source)
       expect { @client.where({level: options[:level]}) }.to raise_error(ArgumentError)
     end

     it 'should request sf1 with valid fields and level params' do
       @client = CensusApi::Client.new(api_key, dataset: source)
       CensusApi::Request.should_receive(:find).with(@client.dataset, options)
       expect { @client.where(options) }.not_to raise_error
     end

     it 'should request sf1 with valid fields, level and within params' do
       @client = CensusApi::Client.new(api_key, dataset: source)
       CensusApi::Request.should_receive(:find).with(@client.dataset, full_params)
       expect { @client.where(full_params) }.not_to raise_error
     end
   end
end