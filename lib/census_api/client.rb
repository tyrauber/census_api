module CensusApi
  class Client
    attr_reader   :api_key, :options
    attr_accessor :dataset

    DATASETS = %w( sf1 ac5 )

    def initialize(options = {})
      raise ArgumentError, "You must set an :api_key." unless options.keys.include? :api_key

      # request = self.find('P0010001', 'STATE:02')
      # raise "Invalid API key." if request[:code] = 302

      @api_key = options[:api_key]

      if options[:dataset]
        @dataset = options[:dataset].downcase if DATASETS.include? options[:dataset].downcase
      end
    end

    def find(field, level, *within)
      Request.find(@dataset, {key: @api_key, fields: field, level: level, within: within})
    end

  end
end
