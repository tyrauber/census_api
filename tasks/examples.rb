require 'yaml'
require 'json'

def self.shapes
  census_shapes = {}
  path = "#{File.dirname(__FILE__)}/../lib/data/census_shapes.yml"
  YAML.load_file(path).each { |k, v| census_shapes[v['attribute']] = k }
  census_shapes
end

def self.name(string)
  n = (shapes[string] || string).gsub(/\s/, '%20')
end

def self.generate(filename, path)
  f = File.open(path, 'r')
  f = JSON.parse(f.read)
  fields = f['get'].shift
  h = {}
  tests = []
  f['fips'].each_with_index do |ex, i|
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
  File.open("#{File.dirname(__FILE__)}/../spec/support/#{filename}.rb", 'w') do |file| 
    file.write("module #{filename.split("_").map(&:capitalize).join}\n  EXAMPLES = [\n")
    file.write(tests.map{ |t| "    #{t}" }.join(",\n"))
    file.write("\n  ]\nend\n")
  end
end

generate("census_2010_dec_sf1", "lib/data/2010/dec/sf1/examples.json")
generate("census_2015_acs_acs5", "lib/data/2015/acs/acs5/examples.json")