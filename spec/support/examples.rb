require 'yaml'
require 'rest-client'
require 'json'

def self.shapes
  census_shapes = {}
  path = "#{File.dirname(__FILE__)}/../../lib/data/census_shapes.yml"
  YAML.load_file(path).each { |k, v| census_shapes[v['attribute']] = k }
  census_shapes
end

def self.name(string)
  n = (shapes[string] || string).gsub(/\s/, '%20')
end

def self.request(url)
  begin
    f = RestClient.get url
    JSON.parse(f.body)
  rescue => e
    raise e
  end
end

def self.read(opts=[])
  open("../support/data/#{opts.join("_")}.rb").read
end

def self.generate(opts=[])
  url = "https://api.census.gov/data/#{opts.join("/")}/examples.json"
  filename = opts.join("_")
  request = request(url)
  fields = request['get'].shift
  h = {}
  tests = []
  request['fips'].each_with_index do |ex, i|
    if ex['in']
      ex['in'].each do |ex_in|
        if ex_in['wildcard']
          tests.push [fields, "#{name(ex['name'])}:*", ex['in'].map{|x| "#{name(x['name'])}:#{
            x['name'] == ex_in['name'] ? '*' : x['exampleValue']
          }"}]
        end
      end
      path = ex['in'].map{|x| "#{name(x['name'])}:#{x['exampleValue']}"}
      tests.push [fields, "#{name(ex['name'])}:*", path]
      tests.push [fields, "#{name(ex['name'])}:#{ex['exampleValue']}", path]
    else
      tests.push [fields, "#{name(ex['name'])}:*"]
      if ex['exampleValue']
        tests.push [fields, "#{name(ex['name'])}:#{ex['exampleValue']}"]
      end
    end
  end
  File.open("#{File.dirname(__FILE__)}/data/census_#{filename}.rb", 'w') do |file| 
    file.write("module Census#{filename.split("_").map(&:capitalize).join}\n  EXAMPLES = [\n")
    file.write(tests.map{ |t| "    #{t}" }.join(",\n"))
    file.write("\n  ]\nend\n")
  end
end
#
#
# generate("census_2010_dec_sf1", "https://api.census.gov/data/2010/dec/sf1/examples.json")
# generate("census_2015_acs_acs5", "https://api.census.gov/data/2015/acs/acs5/examples.json")
#
