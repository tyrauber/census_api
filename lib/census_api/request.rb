module CensusApi
  # => CensusApi::Request
  # client#initialize method takes an url, vintage, source, options hash.
  # client#find method accepts source and options hash, which include
  # :key, :fields, :level, :within and :vintage.
  class Request
    require 'restclient'
    require 'hpricot'
    require 'json'
    require 'yaml'

    attr_accessor :response

    CENSUS_URL = 'http://api.census.gov/data'

    def initialize(url, vintage, source, options)
      uri = Addressable::URI.parse("#{url}/#{vintage}/#{source}")
      uri.query_values = options
      @response = RestClient.get(uri.to_s) do |response, _req, _res, _blk|
        response
      end
    end

    def self.find(source, options = {})
      fields = options[:fields]
      fields = fields.split(',').push('NAME').join(',') if fields.is_a? String
      fields = fields.push('NAME').join(',') if fields.is_a? Array
      level  = format(options[:level], false)
      params = { key: options[:key], get: fields, for: level }
      params.merge!(in: format(options[:within][0], true)) unless options[:within].empty?
      options.merge!(vintage: 2010) unless options[:vintage]
      request = new(CENSUS_URL, options[:vintage], source, params)
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
        message: 'Invalid API key or request',
        location: response.headers[:location],
        body: response.body
      }
    end

    def self.format(str, truncate)
      result = str.split('+').map do |s|
        s = s.match(':') ? s.split(':') : [s, '*']
        shp = shapes[s[0].upcase]
        s.shift && s.unshift(shp['name'].downcase.gsub(' ', '+')) unless shp.nil?
        s.unshift(s.shift.split('/')[0]) if !s[0].scan('home+land').empty? && truncate
        s.join(':')
      end
      result.join('+')
    end

    def self.shapes
      return @@census_shapes if defined?(@@census_shapes)
      @@census_shapes = {}
      path = "#{File.dirname(__FILE__)}/../yml/census_shapes.yml"
      YAML.load_file(path).each { |k, v| @@census_shapes[k] = v }
      @@census_shapes
    end
  end
end
