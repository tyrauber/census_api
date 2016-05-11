require 'spec_helper'

describe CensusApi::Client, :vcr do

  describe 'initialize client' do

    it 'should not initialize without an api_key' do
      lambda { CensusApi::Client.new }.should raise_error
    end

    it 'should initialize with an api_key' do
      @client = CensusApi::Client.new(api_key)
      @client.api_key.should == api_key
    end
  end

  describe 'initialize client and dataset' do

    it 'should initialize with an api_key and dataset' do
      dataset = 'SF1'
      @client = CensusApi::Client.new(api_key, dataset: dataset)
      @client.api_key.should == api_key
      @client.dataset.should == dataset.downcase
    end
  end

  describe 'datasets' do

    describe 'sf1' do
      let(:source) { 'sf1' }
      let(:options) do
        { key: api_key,
          vintage: 2010,
          fields: 'P0010001',
          level: 'STATE:06',
          within: [] }
      end

      it 'should request sf1' do
        @client = CensusApi::Client.new(api_key, dataset: source)
        CensusApi::Request.should_receive(:find).with(@client.dataset, options)
        @client.where(options)
      end
    end

    describe 'acs5' do
      let(:source) { 'acs5' }
      let(:options) do
        { key: api_key,
          vintage: 2010,
          fields: 'B00001_001E',
          level: 'STATE:06',
          within: [] }
      end

      it 'should request acs5' do
        @client = CensusApi::Client.new(api_key, dataset: source)
        CensusApi::Request.should_receive(:find).with(@client.dataset, options)
        @client.where(options)
      end
    end
  end

  describe '#find' do

    let(:source) { 'sf1' }
    let(:options) do
      { key: api_key,
        vintage: 2010,
        fields: 'P0010001',
        level: 'STATE:06',
        within: [] }
    end

    it 'should be deprecated' do
      @client = CensusApi::Client.new(api_key, dataset: source)
      @client.should_receive(:warn)
      .with('[DEPRECATION] `find` is deprecated. Please use `where` instead.')
      @client.find(options[:fields], options[:level])
    end
  end

  describe '#where' do

    let(:source) { 'sf1' }

    let(:options) do
      {
        key: api_key,
        vintage: 2010,
        fields: 'P0010001',
        level: 'STATE:06',
        within: []
      }
    end

    let(:full_params) do
      options.merge!(level: 'COUNTY:001', within: 'STATE:06')
    end

    it 'should raise if missing fields params' do
      @client = CensusApi::Client.new(api_key, dataset: source)
      expect { @client.where(fields: options[:fields]) }
      .to raise_error(ArgumentError)
    end

    it 'should raise if missing level params' do
      @client = CensusApi::Client.new(api_key, dataset: source)
      expect { @client.where(level: options[:level]) }
      .to raise_error(ArgumentError)
    end

    it 'should request sf1 with valid fields and level params' do
      @client = CensusApi::Client.new(api_key, dataset: source)
      CensusApi::Request.should_receive(:find)
      .with(@client.dataset, options)
      expect { @client.where(options) }.not_to raise_error
    end

    it 'should request sf1 with valid fields, level and within params' do
      @client = CensusApi::Client.new(api_key, dataset: source)
      CensusApi::Request.should_receive(:find)
      .with(@client.dataset, full_params)
      expect { @client.where(full_params) }.not_to raise_error
    end
  end
end
