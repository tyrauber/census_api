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
      uri = "/data/#{vintage}/#{source}?#{to_params(options)}"
      @response = $census_connection.get(uri.to_s)
      @response.flush
    end

    def self.find(source, options = {})
      fields = options[:fields]
      fields = fields.split(',').push('NAME').join(',') if fields.is_a? String
      fields = fields.push('NAME').join(',') if fields.is_a? Array
      level  = format(options[:level], false, source)
      params = { key: options[:key], get: fields, for: level }
      unless (options[:within].nil? || (options[:within].is_a?(Array) && options[:within].compact.empty?))
        params.merge!(in: format(options[:within][0], true, source))
      end
      options.merge!(vintage: 2010) unless options[:vintage]
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

    def self.format(str, truncate, source=nil)
      result = str.split('+').map do |s|
        s = s.match(':') ? s.split(':') : [s, '*']
        shp = shapes[s[0].upcase]
        name = shp[[source,'name'].compact.join("_")]||shp['name']
        s.shift && s.unshift(name.downcase.gsub(' ', '+')) unless shp.nil?
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
