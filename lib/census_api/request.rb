module CensusApi
  # => CensusApi::Request
  # client#initialize method takes an url, vintage, source, options hash.
  # client#find method accepts source and options hash, which include
  # :key, :fields, :level, :within and :vintage.
  class Request
    require 'http'
    require 'json'
    require 'yaml'

    attr_accessor :response

    def initialize(vintage, source, options)
      api_changes = [
        {source: 'acs1', from: 2012, to: 2015, new_endpoint: 'acs/acs1'},
        #{source: 'acs3', from: 2012, to: 2013, new_endpoint: 'acs/acs3'},
        {source: 'acs5', from: 2010, to: 2015, new_endpoint: 'acs/acs5'},
        {source: 'acsse', from: 2014, to: 2015, new_endpoint: 'acs/acsse'},
        {source: 'sf1', from: 2010, to: 2010, new_endpoint: 'dec/sf1'}
      ]
      route = api_changes.detect do |a| 
        a[:source] == source && a[:from] <= vintage.to_i && a[:to] >= vintage.to_i
      end
      if route
        source = route[:new_endpoint]
      end
      uri = "/data/#{vintage}/#{source}?#{to_params(options)}"
      @response = $census_connection.get(uri.to_s)
      @response.flush
    end

    def self.find(source, options = {})
      fields = options[:fields]
      fields = fields.split(',').push('NAME').join(',') if fields.is_a? String
      fields = fields.push('NAME').join(',') if fields.is_a? Array
      level  = format(options[:level])
      params = { get: fields, for: level }
      unless options[:within].nil? || (options[:within].is_a?(Array) && options[:within].empty?)
        params.merge!(in: format(options[:within].join("+")))
      end
      options.merge!(vintage: 2010) unless options[:vintage]
      params.merge!(key: options[:key]) if !!(options[:key])
      request = new(options[:vintage], source, params)
      request.parse_response
    end

    def parse_response
      case @response.code
      when 200
        response_success(@response)
      else
        response_error(@response)
      end
    end

    def to_params(options)
      options.map { |k,v| "#{k}=#{v}" }.join("&")
    end

    protected

    def response_success(response)
      response = JSON.parse(response)
      header = response.delete_at(0)
      response.map do |r|
        Hash[header.map { |h| h.gsub('NAME', 'name') }.zip(r)]
      end
    end

    def response_error(response)
      {
        code: response.code,
        location: response.headers[:location],
        body: response.body
      }
    end

    def self.format(str)
      str.split("+").map do |s|
        s = s.match(':') ? s.split(':') : [s, '*']
        name = (shapes[s[0]]['attribute'] rescue s[0]).gsub(/\s/, '%20')
        s.shift && s.unshift(name) && s.join(':')
      end.join("%20")
    end

    def self.shapes
      return @@census_shapes if defined?(@@census_shapes)
      @@census_shapes = {}
      path = "#{File.dirname(__FILE__)}/../data/census_shapes.yml"
      YAML.load_file(path).each { |k, v| @@census_shapes[k] = v }
      @@census_shapes
    end
  end
end
