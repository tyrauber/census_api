module CensusApi
  # => CensusApi::Client
  # client#initialize method takes an api_key and options hash,
  # which includes dataset and vintage. client#where method accepts
  # an options hash, including fields, level and within. Within is optional.
  class Client
    require 'http'
    $census_connection = HTTP.persistent "https://api.census.gov"

    attr_reader :api_key, :api_vintage, :options
    attr_accessor :dataset

    DATASETS = %w( sf1 acs1 acs3 acs5 )
    # can add more datasets as support becomes available

    def initialize(api_key, options = {})
      fail ArgumentError, 'You must set an api_key.' unless api_key
      validate_api_key(api_key)
      @api_key = api_key
      @api_vintage = options[:vintage] || 2010
      if options[:dataset] && DATASETS.include?(options[:dataset].downcase)
        @dataset = options[:dataset].downcase
      end
    end

    def where(options={})
      options.merge!(key: @api_key, vintage: @api_vintage)
      fail "Client requires a dataset (#{DATASETS})." if @dataset.nil?
      [:fields, :level].each do |f|
        fail ArgumentError, "#{f} is a requied parameter" if options[f].nil?
      end
      options[:within] = [options[:within]] unless options[:within].nil?
      Request.find(dataset, options)
    end

    protected

    def validate_api_key(api_key)
      path = "/data/2010/sf1?key=#{api_key}&get=P0010001&for=state:01"
      response = $census_connection.get path
      if response.to_s.include? 'Invalid Key'
        fail "'#{api_key}' is not a valid API key. Check your key for errors,
        or request a new one at census.gov."
      end
    end
  end
end
