module CensusApi
  class Client
    attr_reader   :api_key, :options
    attr_accessor :dataset

    DATASETS = %w( sf1 ac5 )

    def initialize(api_key, dataset, options = {})
      @api_key = api_key
      @dataset = dataset.downcase if DATASETS.include? dataset.downcase
      @options = options
    end

    def find(field, level, *within)
      Request.find(@dataset, {key: @api_key, fields: field, level: level, within: within})
    end

  end
end
