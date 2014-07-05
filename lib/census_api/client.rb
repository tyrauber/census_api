module CensusApi
  class Client
    require 'rest-client'

    attr_reader   :api_key, :api_vintage, :options
    attr_accessor :dataset

    DATASETS = %w( sf1 acs1 acs3 acs5 ) # can add more datasets as support becomes available

    def initialize(api_key, options = {})
      raise ArgumentError, "You must set an api_key." unless api_key

      # Use RestClient directly to determine the validity of the API Key
      path = "http://api.census.gov/data/2010/sf1?key=#{api_key}&get=P0010001&for=state:01"
      response = RestClient.get(path)

      if response.body.include? "Invalid Key"
        raise "'#{api_key}' is not a valid API key. Check your key for errors, or request a new one at census.gov."
      end

      @api_key = api_key
      @api_vintage = options[:vintage] || 2010
      if options[:dataset]
        @dataset = options[:dataset].downcase if DATASETS.include? options[:dataset].downcase
      end
    end

    def find(fields, level, *within)
      warn "[DEPRECATION] `find` is deprecated.  Please use `where` with options hash instead."
      raise "Client has not been assigned a dataset to query. Try @client.dataset = 'SF1' or anything from #{DATASETS}" if self.dataset.nil?
      Request.find(dataset, {key: @api_key,  vintage: @api_vintage, fields: fields, level: level, within: within})
    end

    def where(options ={ key: @api_key,  vintage: @api_vintage })
      raise "Client has not been assigned a dataset to query. Try @client.dataset = 'SF1' or anything from #{DATASETS}" if self.dataset.nil?
      [:fields, :level].each{|f| raise  ArgumentError, "Missing #{f.to_s } parameter required" if options[f].nil? }
      Request.find(dataset, options)
    end
  end
end
