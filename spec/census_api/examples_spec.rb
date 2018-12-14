require 'spec_helper'

describe 'CensusApi::Examples', :vcr do
  
  EXAMPLES.each do |example|

    kls = example.unshift('census').map(&:to_s).map(&:capitalize).join
    
    context kls do
      let(:api_key) { ENV['API_KEY'] || "ABCD" }
      let(:client) { CensusApi::Client.new(api_key, {dataset: example[3], vintage: example[1]} ) }

       examples = Object.const_get(kls)::EXAMPLES
       examples = examples.sample(examples.length/(ENV['SAMPLE_SIZE'] || 6))
       examples.each do |query|
         it "should retrieve #{query.join(",")}" do
           response = client.send(:where, {fields: query[0], level: query[1], within: query[2]})
           expect{ response }.not_to raise_error
           expect(response).to be_a(Array)
           expect(response.first).to include('name')
         end
       end
    end
  end
end