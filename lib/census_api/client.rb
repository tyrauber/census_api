module CensusApi
  class Client
    attr_reader :api_key
    attr_reader :options

    def initialize(api_key, options = {})
      @api_key = api_key
      @options = options
    end

    def sf1(field, level, *within)
      Request.find("sf1", {:key => @api_key, :fields => field, :level => level, :within => within})
    end
    
    def acs5(field, level, *within)
      Request.find("acs5", {:key => @api_key, :fields => field, :level => level,  :within => within})
    end
  end
end