module CensusApi
  class Client
    attr_reader   :api_key, :options
    attr_accessor :dataset

    DATASETS = %w( sf1 ac5 ) # can add more datasets as support becomes available

    def initialize(api_key, options = {})
      raise ArgumentError, "You must set an api_key." unless api_key

      # Use RestClient directly to determine the validity of the API Key
      path = "http://api.census.gov/data/2010/sf1?key=#{api_key}&get=P0010001&for=state:01"
      response = RestClient.get(path)

      if response.body.include? "Invalid Key"
        raise "'#{api_key}' is not a valid API key. Check your key for errors, or request a new one at census.gov."
      end
      
      @api_key = api_key
      if options[:dataset]
        @dataset = options[:dataset].downcase if DATASETS.include? options[:dataset].downcase
      end
    end

    def find(field, level, *within)
      raise "Client has not been assigned a dataset to query. Try @client.dataset = 'SF1' or anything from #{DATASETS}" if self.dataset.nil?
      Request.find(@dataset, {key: @api_key, fields: field, level: level, within: within})
    end

    def dataset=(dataset)
      @dataset = dataset.downcase
    end

  end
end
